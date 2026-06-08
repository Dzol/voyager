defmodule Voyager do
  @moduledoc false

  defmodule Workers.Spider do
    use Oban.Worker

    @impl Oban.Worker
    def perform(%Oban.Job{args: %{"iteration_max" => x, "iteration_num" => x}}) do
      :ok
    end

    def perform(%Oban.Job{
          args: %{"link" => link, "iteration_max" => imax, "iteration_num" => inum}
        }) do
      resp = link |> URI.parse() |> Inimeg.Protocol.fetch()

      try do
        Inimeg.Page.read(resp.body)
      rescue
        _ ->
          :ok
      else
        page ->
          size = byte_size(resp.body)

          %Voyager.Probe.Page{}
          |> Voyager.Probe.Page.changeset(%{
            url: link,
            status: resp.status,
            meta: resp.meta,
            size: size
          })
          |> Voyager.Repo.insert()

          page
          |> Enum.filter(&Inimeg.Content.link?/1)
          |> Enum.map(
            _extract_link = fn x ->
              [link | _] =
                x
                |> String.trim_leading("=>")
                |> String.trim()
                |> String.split(["\s", "\t"], parts: 2)

              URI.parse(link)
            end
          )
          |> Enum.map(
            _from_relative_to_absolute = fn %URI{} = x ->
              if x.scheme == nil or x.host == nil or x.port == nil do
                %{host: host} = URI.parse(link)
                URI.merge(%URI{scheme: "gemini", host: host, port: 1965}, x)
              else
                x
              end
            end
          )
          |> Enum.filter(fn x -> x.scheme == "gemini" end)
          |> Enum.map(&URI.to_string/1)
          |> Enum.map(&%{link: &1, iteration_max: imax, iteration_num: inum + 1})
          |> Enum.map(&Workers.Spider.new/1)
          |> Oban.insert_all()
          |> then(&{:ok, &1})
      end
    end
  end

  def enqueue do
    link = "gemini://mozz.us"

    %{
      link: link,
      iteration_max: 5,
      iteration_num: 0
    }
    |> Workers.Spider.new()
    |> Oban.insert()
  end
end

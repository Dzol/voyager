defmodule Voyager do
  @moduledoc false

  defmodule Workers.Spider do
    use Oban.Worker

    @impl Oban.Worker
    def perform(%Oban.Job{args: %{"link" => link}}) do
      resp = link |> URI.parse() |> Inimeg.Protocol.fetch()

      try do
        Inimeg.Page.read(resp.body)
      rescue
        _ ->
          :ok
      else
        page ->
          size = byte_size(resp.body)

          _links =
            page
            |> Enum.filter(&Inimeg.Content.link?/1)
            |> Enum.map(fn x ->
              [link | _] =
                x
                |> String.trim_leading("=>")
                |> String.trim()
                |> String.split(["\s", "\t"], parts: 2)

              URI.parse(link)
            end)
            |> Enum.map(fn %URI{} = x ->
              if x.scheme == nil or x.host == nil or x.port == nil do
                %{host: host} = URI.parse(link)
                URI.merge(%URI{scheme: "gemini", host: host, port: 1965}, x)
              else
                x
              end
            end)
            |> Enum.filter(fn x -> x.scheme == "gemini" end)

          %Voyager.Probe.Page{}
          |> Voyager.Probe.Page.changeset(%{
            url: link,
            status: resp.status,
            meta: resp.meta,
            size: size
          })
          |> Voyager.Repo.insert()
      end
    end
  end

  def enqueue do
    link = "gemini://mozz.us"

    %{link: link}
    |> Workers.Spider.new()
    |> Oban.insert()
  end
end

defmodule VoyagerWeb.PageJSON do
  alias Voyager.Probe.Page

  @doc """
  Renders a list of pages.
  """
  def index(%{pages: pages}) do
    %{data: for(page <- pages, do: data(page))}
  end

  @doc """
  Renders a single page.
  """
  def show(%{page: page}) do
    %{data: data(page)}
  end

  defp data(%Page{} = page) do
    %{
      id: page.id,
      url: page.url,
      domain: page.domain,
      status: page.status,
      meta: page.meta,
      size: page.size
    }
  end
end

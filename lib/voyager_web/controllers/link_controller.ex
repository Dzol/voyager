defmodule VoyagerWeb.LinkController do
  use VoyagerWeb, :controller

  alias Voyager.Probe
  alias Voyager.Probe.Link

  action_fallback VoyagerWeb.FallbackController

  def index(conn, _params) do
    links = Probe.list_links()
    render(conn, :index, links: links)
  end

  def create(conn, %{"link" => link_params}) do
    with {:ok, %Link{} = link} <- Probe.create_link(link_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/links/#{link}")
      |> render(:show, link: link)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Probe.get_link!(id)
    render(conn, :show, link: link)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = Probe.get_link!(id)

    with {:ok, %Link{} = link} <- Probe.update_link(link, link_params) do
      render(conn, :show, link: link)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = Probe.get_link!(id)

    with {:ok, %Link{}} <- Probe.delete_link(link) do
      send_resp(conn, :no_content, "")
    end
  end
end

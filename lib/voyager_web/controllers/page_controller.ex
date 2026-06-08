defmodule VoyagerWeb.PageController do
  use VoyagerWeb, :controller

  alias Voyager.Probe
  alias Voyager.Probe.Page

  action_fallback VoyagerWeb.FallbackController

  def index(conn, _params) do
    pages = Probe.list_pages()
    render(conn, :index, pages: pages)
  end

  def create(conn, %{"page" => page_params}) do
    with {:ok, %Page{} = page} <- Probe.create_page(page_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/pages/#{page}")
      |> render(:show, page: page)
    end
  end

  def show(conn, %{"id" => id}) do
    page = Probe.get_page!(id)
    render(conn, :show, page: page)
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = Probe.get_page!(id)

    with {:ok, %Page{} = page} <- Probe.update_page(page, page_params) do
      render(conn, :show, page: page)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Probe.get_page!(id)

    with {:ok, %Page{}} <- Probe.delete_page(page) do
      send_resp(conn, :no_content, "")
    end
  end
end

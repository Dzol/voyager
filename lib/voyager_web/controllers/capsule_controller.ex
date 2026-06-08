defmodule VoyagerWeb.CapsuleController do
  use VoyagerWeb, :controller

  alias Voyager.Probe
  alias Voyager.Probe.Capsule

  action_fallback VoyagerWeb.FallbackController

  def index(conn, _params) do
    capsules = Probe.list_capsules()
    render(conn, :index, capsules: capsules)
  end

  def create(conn, %{"capsule" => capsule_params}) do
    with {:ok, %Capsule{} = capsule} <- Probe.create_capsule(capsule_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/capsules/#{capsule}")
      |> render(:show, capsule: capsule)
    end
  end

  def show(conn, %{"id" => id}) do
    capsule = Probe.get_capsule!(id)
    render(conn, :show, capsule: capsule)
  end

  def update(conn, %{"id" => id, "capsule" => capsule_params}) do
    capsule = Probe.get_capsule!(id)

    with {:ok, %Capsule{} = capsule} <- Probe.update_capsule(capsule, capsule_params) do
      render(conn, :show, capsule: capsule)
    end
  end

  def delete(conn, %{"id" => id}) do
    capsule = Probe.get_capsule!(id)

    with {:ok, %Capsule{}} <- Probe.delete_capsule(capsule) do
      send_resp(conn, :no_content, "")
    end
  end
end

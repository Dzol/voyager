defmodule VoyagerWeb.CapsuleControllerTest do
  use VoyagerWeb.ConnCase

  import Voyager.ProbeFixtures
  alias Voyager.Probe.Capsule

  @create_attrs %{
    domain: "some domain",
    robots: "some robots"
  }
  @update_attrs %{
    domain: "some updated domain",
    robots: "some updated robots"
  }
  @invalid_attrs %{domain: nil, robots: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all capsules", %{conn: conn} do
      conn = get(conn, ~p"/api/capsules")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create capsule" do
    test "renders capsule when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/capsules", capsule: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/capsules/#{id}")

      assert %{
               "id" => ^id,
               "domain" => "some domain",
               "robots" => "some robots"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/capsules", capsule: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update capsule" do
    setup [:create_capsule]

    test "renders capsule when data is valid", %{conn: conn, capsule: %Capsule{id: id} = capsule} do
      conn = put(conn, ~p"/api/capsules/#{capsule}", capsule: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/capsules/#{id}")

      assert %{
               "id" => ^id,
               "domain" => "some updated domain",
               "robots" => "some updated robots"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, capsule: capsule} do
      conn = put(conn, ~p"/api/capsules/#{capsule}", capsule: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete capsule" do
    setup [:create_capsule]

    test "deletes chosen capsule", %{conn: conn, capsule: capsule} do
      conn = delete(conn, ~p"/api/capsules/#{capsule}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/capsules/#{capsule}")
      end
    end
  end

  defp create_capsule(_) do
    capsule = capsule_fixture()

    %{capsule: capsule}
  end
end

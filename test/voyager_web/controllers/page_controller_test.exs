defmodule VoyagerWeb.PageControllerTest do
  use VoyagerWeb.ConnCase

  import Voyager.ProbeFixtures
  alias Voyager.Probe.Page

  @create_attrs %{
    meta: "some meta",
    size: 42,
    status: 42,
    domain: "some domain",
    url: "some url"
  }
  @update_attrs %{
    meta: "some updated meta",
    size: 43,
    status: 43,
    domain: "some updated domain",
    url: "some updated url"
  }
  @invalid_attrs %{meta: nil, size: nil, status: nil, domain: nil, url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pages", %{conn: conn} do
      conn = get(conn, ~p"/api/pages")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create page" do
    test "renders page when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/pages", page: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/pages/#{id}")

      assert %{
               "id" => ^id,
               "domain" => "some domain",
               "meta" => "some meta",
               "size" => 42,
               "status" => 42,
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/pages", page: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update page" do
    setup [:create_page]

    test "renders page when data is valid", %{conn: conn, page: %Page{id: id} = page} do
      conn = put(conn, ~p"/api/pages/#{page}", page: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/pages/#{id}")

      assert %{
               "id" => ^id,
               "domain" => "some updated domain",
               "meta" => "some updated meta",
               "size" => 43,
               "status" => 43,
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, page: page} do
      conn = put(conn, ~p"/api/pages/#{page}", page: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete page" do
    setup [:create_page]

    test "deletes chosen page", %{conn: conn, page: page} do
      conn = delete(conn, ~p"/api/pages/#{page}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/pages/#{page}")
      end
    end
  end

  defp create_page(_) do
    page = page_fixture()

    %{page: page}
  end
end

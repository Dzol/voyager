defmodule Voyager.ProbeTest do
  use Voyager.DataCase

  alias Voyager.Probe

  describe "pages" do
    alias Voyager.Probe.Page

    import Voyager.ProbeFixtures

    @invalid_attrs %{meta: nil, size: nil, status: nil, domain: nil, url: nil}

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Probe.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Probe.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      valid_attrs = %{
        meta: "some meta",
        size: 42,
        status: 42,
        domain: "some domain",
        url: "some url"
      }

      assert {:ok, %Page{} = page} = Probe.create_page(valid_attrs)
      assert page.meta == "some meta"
      assert page.size == 42
      assert page.status == 42
      assert page.domain == "some domain"
      assert page.url == "some url"
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Probe.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()

      update_attrs = %{
        meta: "some updated meta",
        size: 43,
        status: 43,
        domain: "some updated domain",
        url: "some updated url"
      }

      assert {:ok, %Page{} = page} = Probe.update_page(page, update_attrs)
      assert page.meta == "some updated meta"
      assert page.size == 43
      assert page.status == 43
      assert page.domain == "some updated domain"
      assert page.url == "some updated url"
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Probe.update_page(page, @invalid_attrs)
      assert page == Probe.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Probe.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Probe.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Probe.change_page(page)
    end
  end

  describe "links" do
    alias Voyager.Probe.Link

    import Voyager.ProbeFixtures

    @invalid_attrs %{label: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Probe.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Probe.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{label: "some label"}

      assert {:ok, %Link{} = link} = Probe.create_link(valid_attrs)
      assert link.label == "some label"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Probe.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{label: "some updated label"}

      assert {:ok, %Link{} = link} = Probe.update_link(link, update_attrs)
      assert link.label == "some updated label"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Probe.update_link(link, @invalid_attrs)
      assert link == Probe.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Probe.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Probe.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Probe.change_link(link)
    end
  end

  describe "capsules" do
    alias Voyager.Probe.Capsule

    import Voyager.ProbeFixtures

    @invalid_attrs %{domain: nil, robots: nil}

    test "list_capsules/0 returns all capsules" do
      capsule = capsule_fixture()
      assert Probe.list_capsules() == [capsule]
    end

    test "get_capsule!/1 returns the capsule with given id" do
      capsule = capsule_fixture()
      assert Probe.get_capsule!(capsule.id) == capsule
    end

    test "create_capsule/1 with valid data creates a capsule" do
      valid_attrs = %{domain: "some domain", robots: "some robots"}

      assert {:ok, %Capsule{} = capsule} = Probe.create_capsule(valid_attrs)
      assert capsule.domain == "some domain"
      assert capsule.robots == "some robots"
    end

    test "create_capsule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Probe.create_capsule(@invalid_attrs)
    end

    test "update_capsule/2 with valid data updates the capsule" do
      capsule = capsule_fixture()
      update_attrs = %{domain: "some updated domain", robots: "some updated robots"}

      assert {:ok, %Capsule{} = capsule} = Probe.update_capsule(capsule, update_attrs)
      assert capsule.domain == "some updated domain"
      assert capsule.robots == "some updated robots"
    end

    test "update_capsule/2 with invalid data returns error changeset" do
      capsule = capsule_fixture()
      assert {:error, %Ecto.Changeset{}} = Probe.update_capsule(capsule, @invalid_attrs)
      assert capsule == Probe.get_capsule!(capsule.id)
    end

    test "delete_capsule/1 deletes the capsule" do
      capsule = capsule_fixture()
      assert {:ok, %Capsule{}} = Probe.delete_capsule(capsule)
      assert_raise Ecto.NoResultsError, fn -> Probe.get_capsule!(capsule.id) end
    end

    test "change_capsule/1 returns a capsule changeset" do
      capsule = capsule_fixture()
      assert %Ecto.Changeset{} = Probe.change_capsule(capsule)
    end
  end
end

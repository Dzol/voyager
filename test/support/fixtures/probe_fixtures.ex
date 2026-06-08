defmodule Voyager.ProbeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Voyager.Probe` context.
  """

  @doc """
  Generate a page.
  """
  def page_fixture(attrs \\ %{}) do
    {:ok, page} =
      attrs
      |> Enum.into(%{
        domain: "some domain",
        meta: "some meta",
        size: 42,
        status: 42,
        url: "some url"
      })
      |> Voyager.Probe.create_page()

    page
  end

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        label: "some label"
      })
      |> Voyager.Probe.create_link()

    link
  end

  @doc """
  Generate a capsule.
  """
  def capsule_fixture(attrs \\ %{}) do
    {:ok, capsule} =
      attrs
      |> Enum.into(%{
        domain: "some domain",
        robots: "some robots"
      })
      |> Voyager.Probe.create_capsule()

    capsule
  end
end

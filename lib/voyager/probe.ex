defmodule Voyager.Probe do
  @moduledoc """
  The Probe context.
  """

  import Ecto.Query, warn: false
  alias Voyager.Repo

  alias Voyager.Probe.Page

  @doc """
  Returns the list of pages.

  ## Examples

      iex> list_pages()
      [%Page{}, ...]

  """
  def list_pages do
    Repo.all(Page)
  end

  @doc """
  Gets a single page.

  Raises `Ecto.NoResultsError` if the Page does not exist.

  ## Examples

      iex> get_page!(123)
      %Page{}

      iex> get_page!(456)
      ** (Ecto.NoResultsError)

  """
  def get_page!(id), do: Repo.get!(Page, id)

  @doc """
  Creates a page.

  ## Examples

      iex> create_page(%{field: value})
      {:ok, %Page{}}

      iex> create_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_page(attrs) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a page.

  ## Examples

      iex> update_page(page, %{field: new_value})
      {:ok, %Page{}}

      iex> update_page(page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_page(%Page{} = page, attrs) do
    page
    |> Page.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a page.

  ## Examples

      iex> delete_page(page)
      {:ok, %Page{}}

      iex> delete_page(page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_page(%Page{} = page) do
    Repo.delete(page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking page changes.

  ## Examples

      iex> change_page(page)
      %Ecto.Changeset{data: %Page{}}

  """
  def change_page(%Page{} = page, attrs \\ %{}) do
    Page.changeset(page, attrs)
  end

  alias Voyager.Probe.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """
  def list_links do
    Repo.all(Link)
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(attrs) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{data: %Link{}}

  """
  def change_link(%Link{} = link, attrs \\ %{}) do
    Link.changeset(link, attrs)
  end

  alias Voyager.Probe.Capsule

  @doc """
  Returns the list of capsules.

  ## Examples

      iex> list_capsules()
      [%Capsule{}, ...]

  """
  def list_capsules do
    Repo.all(Capsule)
  end

  @doc """
  Gets a single capsule.

  Raises `Ecto.NoResultsError` if the Capsule does not exist.

  ## Examples

      iex> get_capsule!(123)
      %Capsule{}

      iex> get_capsule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_capsule!(id), do: Repo.get!(Capsule, id)

  @doc """
  Creates a capsule.

  ## Examples

      iex> create_capsule(%{field: value})
      {:ok, %Capsule{}}

      iex> create_capsule(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_capsule(attrs) do
    %Capsule{}
    |> Capsule.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a capsule.

  ## Examples

      iex> update_capsule(capsule, %{field: new_value})
      {:ok, %Capsule{}}

      iex> update_capsule(capsule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_capsule(%Capsule{} = capsule, attrs) do
    capsule
    |> Capsule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a capsule.

  ## Examples

      iex> delete_capsule(capsule)
      {:ok, %Capsule{}}

      iex> delete_capsule(capsule)
      {:error, %Ecto.Changeset{}}

  """
  def delete_capsule(%Capsule{} = capsule) do
    Repo.delete(capsule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking capsule changes.

  ## Examples

      iex> change_capsule(capsule)
      %Ecto.Changeset{data: %Capsule{}}

  """
  def change_capsule(%Capsule{} = capsule, attrs \\ %{}) do
    Capsule.changeset(capsule, attrs)
  end
end

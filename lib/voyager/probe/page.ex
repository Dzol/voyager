defmodule Voyager.Probe.Page do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pages" do
    field :url, :string
    field :domain, :string
    field :status, :integer
    field :meta, :string
    field :size, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:url, :domain, :status, :meta, :size])
    |> validate_required([:url, :domain, :status, :meta, :size])
  end
end

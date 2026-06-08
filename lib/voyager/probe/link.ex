defmodule Voyager.Probe.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :label, :string
    field :source_page, :id
    field :target_page, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:label])
    |> validate_required([:label])
  end
end

defmodule Voyager.Probe.Capsule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "capsules" do
    field :domain, :string
    # To-Do: Talking-point on how to go about robots.txt (at scale and otherwise)
    field :robots, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(capsule, attrs) do
    capsule
    |> cast(attrs, [:domain, :robots])
    |> validate_required([:domain, :robots])
  end
end

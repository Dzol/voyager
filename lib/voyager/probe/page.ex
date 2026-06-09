defmodule Voyager.Probe.Page do
  use Ecto.Schema
  import Ecto.Changeset

  #
  # Interesting fields that might introduce considerable complexity to
  # code-base:
  #
  # - Peer Stack, IP address, & port number
  # - SSL/TLS certificate information
  # - Redirect chain
  # - Latency
  # - Internal/External Link count
  #

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
    |> validate_required([:url])
  end
end

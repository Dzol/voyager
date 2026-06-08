defmodule VoyagerWeb.CapsuleJSON do
  alias Voyager.Probe.Capsule

  @doc """
  Renders a list of capsules.
  """
  def index(%{capsules: capsules}) do
    %{data: for(capsule <- capsules, do: data(capsule))}
  end

  @doc """
  Renders a single capsule.
  """
  def show(%{capsule: capsule}) do
    %{data: data(capsule)}
  end

  defp data(%Capsule{} = capsule) do
    %{
      id: capsule.id,
      domain: capsule.domain,
      robots: capsule.robots
    }
  end
end

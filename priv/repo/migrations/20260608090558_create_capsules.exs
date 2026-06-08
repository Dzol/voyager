defmodule Voyager.Repo.Migrations.CreateCapsules do
  use Ecto.Migration

  def change do
    create table(:capsules) do
      add :domain, :string
      add :robots, :text

      timestamps(type: :utc_datetime)
    end
  end
end

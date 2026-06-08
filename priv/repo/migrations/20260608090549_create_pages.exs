defmodule Voyager.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :url, :string
      add :domain, :string
      add :status, :integer
      add :meta, :text
      add :size, :integer

      timestamps(type: :utc_datetime)
    end
  end
end

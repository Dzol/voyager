defmodule Voyager.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :label, :string
      add :source_page, references(:pages, on_delete: :nothing)
      add :target_page, references(:pages, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:links, [:source_page])
    create index(:links, [:target_page])
  end
end

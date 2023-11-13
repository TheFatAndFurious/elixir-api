defmodule Api.Repo.Migrations.CreateGalleries do
  use Ecto.Migration

  def change do
    create table(:galleries) do
      add :name, :string
      add :person_id, references(:people)
      timestamps()
    end
  end
end

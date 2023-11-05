defmodule Api.Repo.Migrations.CreatePictures do
  use Ecto.Migration

  def change do
    create table(:pictures) do
      add :url,  :string
      timestamps()
    end
  end
end

defmodule Api.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      timestamps()
    end
  end
end

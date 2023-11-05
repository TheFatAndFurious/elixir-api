defmodule Api.Repo.Migrations.CreatePicturesGalleries do
  use Ecto.Migration

  def change do
    create table(:pictures_galleries) do
      add :picture_id, references(:pictures)
      add :gallery_id, references(:galleries)
    end

    create unique_index(:pictures_galleries, [:picture_id, :gallery_id])
  end
end

defmodule Api.Repo.Migrations.CreatePeopleGroups do
  use Ecto.Migration

  def change do
    create table(:people_groups) do
      add :person_id, references(:people)
      add :group_id, references(:groups)
    end

    create unique_index(:people_groups, [:person_id, :group_id])
  end
end

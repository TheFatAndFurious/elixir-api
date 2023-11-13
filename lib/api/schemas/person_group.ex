defmodule Api.PersonGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people_groups" do
    belongs_to :person, Api.Person
    belongs_to :group, Api.Group

    timestamps()
  end

  @doc false
  def changeset(person_group, attrs) do
    person_group
    |> cast(attrs, [:person_id, :group_id])
    |> validate_required([:person_id, :group_id])
  end
end

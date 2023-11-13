defmodule Api.Person do
  use Ecto.Schema

  schema "people" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    has_many :galleries, Api.Gallery
    belongs_to :role, Api.Role
    timestamps()
  end

  def changeset(person, params \\ %{}) do
    person
    |> Ecto.Changeset.cast(params, [:first_name, :last_name, :email, :role_id])
    |> Ecto.Changeset.validate_required([:first_name, :last_name])
  end

  def map_resource(person) do
    %{
      first_name: person.first_name,
      email: person.email,
      #role_id: person.role,
      last_name: person.last_name,
    }
  end
end

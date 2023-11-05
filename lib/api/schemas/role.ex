defmodule Api.Role do
  use Ecto.Schema

  schema "roles" do
    field :name, :string
    has_many :people, Api.Person
    timestamps()
  end

  def changeset(role, params \\ %{}) do
    role
    |> Ecto.Changeset.cast(params, [:name])
    |> Ecto.Changeset.validate_required([:name])
  end
end

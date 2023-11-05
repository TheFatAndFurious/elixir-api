defmodule Api.Group do
  use Ecto.Schema

  schema "groups" do
    field :name, :string
    many_to_many :people, Api.Person, join_through: "people_groups"
    timestamps()
  end
end

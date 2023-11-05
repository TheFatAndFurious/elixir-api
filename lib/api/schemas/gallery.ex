defmodule Api.Gallery do
  use Ecto.Schema

  schema "galleries" do
    field :name, :string
    belongs_to :person, Api.Person
    many_to_many :pictures, Api.Picture, join_through: "pictures_galleries"
    timestamps()
  end
end

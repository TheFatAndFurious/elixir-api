defmodule Api.Picture do
  use Ecto.Schema

  schema "pictures" do
    field :url, :string
    many_to_many :galleries, Api.Gallery, join_through: "pictures_galleries"
    timestamps()
  end
end

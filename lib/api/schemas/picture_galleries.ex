defmodule Api.PictureGallery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pictures_galleries" do
    belongs_to :picture, Api.Picture
    belongs_to :gallery, Api.Gallery

    timestamps()
  end

  @doc false
  def changeset(picture_gallery, attrs) do
    picture_gallery
    |> cast(attrs, [:picture_id, :gallery_id])
    |> validate_required([:picture_id, :gallery_id])
  end

  def map_resource(pictureGallery) do
    %{
      url: picture.url,
    }
  end
end

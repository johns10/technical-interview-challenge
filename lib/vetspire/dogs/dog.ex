defmodule Vetspire.Dogs.Dog do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema

  @primary_key false
  @foreign_key_type :binary_id
  schema "dogs" do
    field :id, :string
    field :name, :string
    field :file, :string
    timestamps()
  end

  @doc false
  def changeset(dogs, attrs) do
    dogs
    |> cast(attrs, [:name, :id])
    |> assign_id()
    |> validate_required([:name])
    |> cast_attachments(attrs, [:file])
  end


  def assign_id(changeset) do
    case get_field(changeset, :name) do
      nil -> changeset
      name -> Ecto.Changeset.put_change(changeset, :id, Recase.to_snake(name))
    end
  end
end

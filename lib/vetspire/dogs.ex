defmodule Vetspire.Dogs do
  @moduledoc """
  The VetspireWeb context.
  """

  import Ecto.Query, warn: false
  alias Vetspire.Dogs.Dog
  alias Vetspire.Generator

  @doc """
  Returns the list of dogs.

  ## Examples

      iex> list_dogs()
      [%Dogs{}, ...]

  """
  def list_dogs() do
    File.ls!(Generator.images_dir(File.cwd!))
    |> Enum.map(fn(file_name) ->
      name = String.slice(file_name, 0..-5)
      %Dog{name: name, id: Recase.to_snake(name)}
    end)
    |> Enum.sort(&(&1.name <= &2.name))
  end

  def filter_dogs(term) do
    list_dogs()
    |> Enum.filter(fn(d) ->
      String.contains?(d.name |> String.downcase(), term)
    end)
  end

  @doc """
  Gets a single dogs.

  Raises `Ecto.NoResultsError` if the Dogs does not exist.

  ## Examples

      iex> get_dogs!(123)
      %Dogs{}

      iex> get_dogs!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dog!(id) do
    File.ls!(Generator.images_dir(File.cwd!))
    |> Enum.map(fn(file_name) ->
      name = String.slice(file_name, 0..-5)
      %Dog{name: name, id: Recase.to_snake(name)}
    end)
    |> Enum.find(fn(d) -> d.id == id end)
  end

  @doc """
  Creates a dogs.

  ## Examples

      iex> create_dogs(%{field: value})
      {:ok, %Dogs{}}

      iex> create_dogs(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dogs(attrs \\ %{}) do
    %Dog{}
    |> change_dog(attrs)
    |> Ecto.Changeset.apply_action(:insert)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dogs changes.

  ## Examples

      iex> change_dog(dogs)
      %Ecto.Changeset{data: %Dogs{}}

  """
  def change_dog(%Dog{} = dogs, attrs \\ %{}) do
    Dog.changeset(dogs, attrs)
  end
end

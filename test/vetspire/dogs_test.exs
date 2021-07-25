defmodule Vetspire.DogsTest do
  use Vetspire.DataCase

  alias Vetspire.Dogs

  @invalid_attrs %{name: nil}
  @valid_attrs %{name: "Doggy Dog"}

  describe "dogs" do
    alias Vetspire.Dogs.Dog

    test "list_dogs/0 returns all dogs" do
      [dog | _] =  Dogs.list_dogs()
      assert dog.name == "Affenpinscher"
    end

    test "get_dogs!/1 returns the dogs with given id" do
      dog = Dogs.get_dog!("toy_poodle")
      assert dog.name == "Toy Poodle"
    end

    test "filter_dogs/1 returns filtered results" do
      [dog | _dogs] = dogs = Dogs.filter_dogs("mini")
      assert dog.name == "Miniature Pinscher"
      assert Enum.count(dogs) == 3
    end

    test "create_dogs/1 with valid data creates a dogs" do
      {:ok, %Dog{} = dog} = Dogs.create_dogs(@valid_attrs)
      assert dog.name == @valid_attrs |> Map.get(:name)
    end

    test "create_dogs/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dogs.create_dogs(@invalid_attrs)
    end

  end
end

defmodule VetspireWeb.VetspireWeb.DogsLiveTest do
  use VetspireWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Vetspire.Dogs
  alias Vetspire.Dogs.Dog

  @invalid_attrs %{name: ""}
  @valid_attrs %{name: "Doggy Dog"}

  describe "Index" do
    test "lists all dogs", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.dogs_index_path(conn, :index))

      assert html =~ "Listing Dogs"
    end
  end

  describe "Show" do
    test "displays dogs", %{conn: conn} do
      {:ok, _show_live, html} = live(conn, Routes.dogs_show_path(conn, :show, %Dog{id: "collie"}))

      assert html =~ "Show Dogs"
    end

    test "saves new dogs", %{conn: conn} do
      dog = Dogs.get_dog!("boxer")
      {:ok, index_live, _html} = live(conn, Routes.dogs_show_path(conn, :new, dog))

      assert index_live |> element("a", "New Dog") |> render_click() =~
               "New Dog"

      assert_patch(index_live, Routes.dogs_show_path(conn, :new, dog))

      assert index_live
             |> form("#dog-form", dog: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      new_dog = %Dog{name: "Doggy Dog", id: "doggy_dog"}

      {:ok, _, html} =
        index_live
        |> form("#dog-form", dog: @valid_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.dogs_show_path(conn, :show, new_dog))

      assert html =~ "Doggy Dog"
    end
  end
end

defmodule VetspireWeb.DogsLive.FormComponent do
  @moduledoc false
  use VetspireWeb, :live_component

  alias Vetspire.Dogs
  alias Vetspire.Dogs.Dog

  @impl true
  def update(assigns, socket) do
    changeset = Dogs.change_dog(%Dog{})

    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(:changeset, changeset)
      |> assign(:uploaded_files, [])
      |> allow_upload(:file, accept: ~w(.jpg), max_entries: 1)
    }
  end

  @impl true
  def handle_event("validate", %{"dog" => dog_params}, socket) do
    changeset =
      socket.assigns.dog
      |> Dogs.change_dog(dog_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"dog" => dog_params}, socket) do
    name = dog_params["name"]
    consume_uploaded_entries(socket, :file, fn %{path: path}, _entry ->
      file_name = name <> ".jpg"
      dest = Path.join([File.cwd!, "assets", "static", "images", file_name])
      File.cp!(path, dest)
      Routes.static_path(socket, "/images/#{file_name}")
    end)

    {:ok, dog} = Dogs.create_dogs(dog_params)

    {
      :noreply,
      socket
      |> push_redirect(to: Routes.dogs_show_path(socket, :show, dog))
    }
  end
end

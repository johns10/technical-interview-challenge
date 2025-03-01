defmodule VetspireWeb.DogsLive.Index do
  @moduledoc false
  use VetspireWeb, :live_view

  alias Vetspire.Dogs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :dogs_collection, list_dogs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Dogs")
    |> assign(:dogs, nil)
  end

  defp list_dogs do
    Dogs.list_dogs()
  end
end

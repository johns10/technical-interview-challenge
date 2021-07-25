defmodule VetspireWeb.DogsLive.Show do
  @moduledoc false
  use VetspireWeb, :live_view

  alias Vetspire.Dogs
  alias Vetspire.Dogs.Dog

  @impl true
  def mount(_params, _session, socket) do
    changeset = Dogs.change_dog(%Dog{})
    {
      :ok,
      socket
      |> assign(:result, [])
      |> assign(:term, "")
      |> assign(:activate, true)
      |> assign(:changeset, changeset)
    }
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {
      :noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:dog, Dogs.get_dog!(id))
    }
  end

  @impl true
  def handle_event("search", %{"dog" => %{"name" => term}}, socket) do
    {
      :noreply,
      socket
      |> assign(:result, search(term))
      |> assign(:term, term)
    }
  end
  def handle_event("activate", _, socket) do
    {
      :noreply,
      socket
      |> assign(:activate, true)
      |> assign(:result, search(socket.assigns.term))
    }
  end
  def handle_event("deactivate", _, socket) do
    {
      :noreply,
      socket
      |> assign(:result, [])
    }
  end

  defp page_title(:show), do: "Show Dogs"
  defp page_title(:edit), do: "Edit Dogs"
  defp page_title(:new), do: "New Dog"

  defp search(term) do
    Dogs.filter_dogs(term)
    |> Enum.slice(0..5)
  end
end

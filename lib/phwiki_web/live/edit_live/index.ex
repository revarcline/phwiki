defmodule PhwikiWeb.EditLive.Index do
  use PhwikiWeb, :live_view

  alias Phwiki.Wiki
  alias Phwiki.Wiki.Edit

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :edits, list_edits())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Edit")
    |> assign(:edit, Wiki.get_edit!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Edit")
    |> assign(:edit, %Edit{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Edits")
    |> assign(:edit, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    edit = Wiki.get_edit!(id)
    {:ok, _} = Wiki.delete_edit(edit)

    {:noreply, assign(socket, :edits, list_edits())}
  end

  defp list_edits do
    Wiki.list_edits()
  end
end

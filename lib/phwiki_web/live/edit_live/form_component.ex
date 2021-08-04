defmodule PhwikiWeb.EditLive.FormComponent do
  use PhwikiWeb, :live_component

  alias Phwiki.Wiki

  @impl true
  def update(%{edit: edit} = assigns, socket) do
    changeset = Wiki.change_edit(edit)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"edit" => edit_params}, socket) do
    changeset =
      socket.assigns.edit
      |> Wiki.change_edit(edit_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"edit" => edit_params}, socket) do
    save_edit(socket, socket.assigns.action, edit_params)
  end

  defp save_edit(socket, :edit, edit_params) do
    case Wiki.update_edit(socket.assigns.edit, edit_params) do
      {:ok, _edit} ->
        {:noreply,
         socket
         |> put_flash(:info, "Edit updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_edit(socket, :new, edit_params) do
    case Wiki.create_edit(edit_params) do
      {:ok, _edit} ->
        {:noreply,
         socket
         |> put_flash(:info, "Edit created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

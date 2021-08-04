defmodule PhwikiWeb.ArticleLive.Index do
  use PhwikiWeb, :live_view

  alias Phwiki.Wiki
  alias Phwiki.Wiki.Article

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :articles, list_articles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Article")
    |> assign(:article, Wiki.get_article!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Article")
    |> assign(:article, %Article{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Articles")
    |> assign(:article, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    article = Wiki.get_article!(id)
    {:ok, _} = Wiki.delete_article(article)

    {:noreply, assign(socket, :articles, list_articles())}
  end

  defp list_articles do
    Wiki.list_articles()
  end
end

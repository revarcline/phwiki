defmodule Phwiki.WikiFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Phwiki.Wiki` context.
  """

  alias Phwiki.Accounts.User
  alias Phwiki.Wiki.Article

  def valid_article_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      title: "Valid Article Title"
    })
  end

  def valid_edit_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      content: "Valid Edit Content"
    })
  end

  def article_fixture(%User{} = user, article_attrs \\ %{}, edit_attrs \\ %{}) do
    first_edit = valid_edit_attrs(edit_attrs)
    first_article = valid_article_attrs(article_attrs)

    {:ok, article} =
      Phwiki.Wiki.create_article(user, first_article, first_edit)
      |> Phwiki.Repo.preload(:edits)

    article
  end

  def edit_fixture(%Article{} = article, %User{} = user, attrs \\ %{}) do
    edit_attrs = valid_edit_attrs(attrs)

    {:ok, edit} =
      Phwiki.Wiki.create_article_edit(article, user, edit_attrs)
      |> Phwiki.Repo.preload([:article, :user])

    edit
  end
end

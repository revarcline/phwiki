defmodule Phwiki.WikiFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Phwiki.Wiki` context.
  """

  import Phwiki.AccountsFixtures

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

  @default_user user_fixture()

  def article_fixture(%User{} = user \\ @default_user, article_attrs \\ %{}, edit_attrs \\ %{}) do
    edit_attr = valid_edit_attrs(edit_attrs)
    article_attr = valid_article_attrs(article_attrs)

    {:ok, article} = Phwiki.Wiki.create_article(user, article_attr, edit_attr)
    article
  end
end

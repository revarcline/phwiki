defmodule Phwiki.WikiTest do
  use Phwiki.DataCase

  alias Phwiki.Wiki
  alias Phwiki.Accounts

  import Phwiki.AccountsFixtures
  import Phwiki.WikiFixtures

  describe "articles" do
    alias Phwiki.Wiki.Article

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Wiki.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Wiki.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Wiki.create_article(@valid_attrs)
      assert article.title == "some title"
      assert article.slug == "some-title"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wiki.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Wiki.update_article(article, @update_attrs)
      assert article.title == "some updated title"
      assert article.slug == "some-updated-title"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Wiki.update_article(article, @invalid_attrs)
      assert article == Wiki.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Wiki.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Wiki.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Wiki.change_article(article)
    end
  end

  describe "edits" do
    alias Phwiki.Wiki.Edit

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def edit_fixture(attrs \\ %{}) do
      {:ok, edit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wiki.create_edit()

      edit
    end

    test "list_edits/0 returns all edits" do
      edit = edit_fixture()
      assert Wiki.list_edits() == [edit]
    end

    test "get_edit!/1 returns the edit with given id" do
      edit = edit_fixture()
      assert Wiki.get_edit!(edit.id) == edit
    end

    test "create_edit/1 with valid data creates a edit" do
      assert {:ok, %Edit{} = edit} = Wiki.create_edit(@valid_attrs)
      assert edit.content == "some content"
    end

    test "create_edit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wiki.create_edit(@invalid_attrs)
    end

    test "update_edit/2 with valid data updates the edit" do
      edit = edit_fixture()
      assert {:ok, %Edit{} = edit} = Wiki.update_edit(edit, @update_attrs)
      assert edit.content == "some updated content"
    end

    test "update_edit/2 with invalid data returns error changeset" do
      edit = edit_fixture()
      assert {:error, %Ecto.Changeset{}} = Wiki.update_edit(edit, @invalid_attrs)
      assert edit == Wiki.get_edit!(edit.id)
    end

    test "delete_edit/1 deletes the edit" do
      edit = edit_fixture()
      assert {:ok, %Edit{}} = Wiki.delete_edit(edit)
      assert_raise Ecto.NoResultsError, fn -> Wiki.get_edit!(edit.id) end
    end

    test "change_edit/1 returns a edit changeset" do
      edit = edit_fixture()
      assert %Ecto.Changeset{} = Wiki.change_edit(edit)
    end
  end
end

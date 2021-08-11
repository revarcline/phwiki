defmodule Phwiki.Wiki do
  @moduledoc """
  The Wiki context.
  """

  import Ecto.Query, warn: false
  alias Phwiki.Repo
  alias Phwiki.Wiki.Article
  alias Phwiki.Wiki.Edit
  alias Phwiki.Accounts.User

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles do
    Repo.all(Article)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id) do
    Article
    |> preload_last_edit()
    |> Repo.get!(id)
  end

  @doc """
  Gets a single article by slug.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article_by_slug!('article')
      %Article{}

      iex> get_article_by_slub!('bad-article')
      ** (Ecto.NoResultsError)

  """
  def get_article_by_slug!(slug) do
    Article
    |> preload_last_edit()
    |> Repo.get_by!(slug: slug)
  end

  defp preload_last_edit(query) do
    edit_query = from e in Edit, order_by: [desc: e.updated_at], limit: 1
    preload(query, edits: ^edit_query)
  end

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(%User{} = user, article_attrs \\ %{}, edit_attrs \\ %{}) do
    {:ok, article} =
      %Article{}
      |> Article.changeset(article_attrs)
      |> Repo.insert()

    create_article_edit(article, user, edit_attrs)
  end

  def create_article_edit(%Article{} = article, %User{} = user, edit_attrs \\ %{}) do
    article
    |> Ecto.build_assoc(:edits, edit_attrs)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{data: %Article{}}

  """
  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end

  def get_article_edits!(id) do
    article =
      Article
      |> preload_all_edits()
      |> Repo.get!(id)

    article.edits
  end

  def get_article_edits_by_slug!(slug) do
    article =
      Article
      |> preload_all_edits()
      |> Repo.get_by(slug: slug)
      |> Repo.preload(:edits)

    article.edits
  end

  defp preload_all_edits(query) do
    edit_query = from e in Edit, order_by: [desc: e.updated_at]
    preload(query, edits: ^edit_query)
  end

  @doc """
  Returns the list of edits.

  ## Examples

      iex> list_edits()
      [%Edit{}, ...]

  """
  def list_edits do
    Edit
    |> Repo.all()
    |> Repo.preload(:article)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single edit.

  Raises `Ecto.NoResultsError` if the Edit does not exist.

  ## Examples

      iex> get_edit!(123)
      %Edit{}

      iex> get_edit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_edit!(id) do
    Edit
    |> Repo.get!(id)
    |> Repo.preload(:article)
    |> Repo.preload(:user)
  end

  @doc """

  """
  def revert_article_edit(%User{} = user, id) do
    edit = get_edit!(id)
    create_article_edit(edit.article, user, %{content: edit.content})
  end

  @doc """
  Deletes a edit.

  ## Examples

      iex> delete_edit(edit)
      {:ok, %Edit{}}

      iex> delete_edit(edit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_edit(%Edit{} = edit) do
    Repo.delete(edit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking edit changes.

  ## Examples

      iex> change_edit(edit)
      %Ecto.Changeset{data: %Edit{}}

  """
  def change_edit(%Edit{} = edit, attrs \\ %{}) do
    Edit.changeset(edit, attrs)
  end
end

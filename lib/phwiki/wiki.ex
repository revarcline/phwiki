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
    |> Repo.get!(id)
    |> Repo.preload(:edits)
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
    |> Repo.get_by!(slug: slug)
    |> Repo.preload(:edits)
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
    %Article{}
    |> Article.changeset(article_attrs)
    |> Repo.insert()
    |> create_article_edit(user, edit_attrs)
  end

  def create_article_edit(%Article{} = article, %User{} = user, edit_attrs \\ %{}) do
    %Edit{}
    |> Ecto.build_assoc(article, edit_attrs)
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

  @doc """
  Returns the list of an article's edits.

  ## Examples

      iex> list_article_edits(article)
      [%Edit{}, ...]

  """
  def list_article_edits(%Article{} = article) do
    article
    |> Repo.preload(:edits)

    article.edits
  end

  @doc """
  Returns the list of edits.

  ## Examples

      iex> list_edits()
      [%Edit{}, ...]

  """
  def last_article_edit(%Article{} = article) do
    article.edits
  end

  @doc """
  Returns the list of edits.

  ## Examples

      iex> list_edits()
      [%Edit{}, ...]

  """
  def list_edits do
    Repo.all(Edit)
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
  def get_edit!(id), do: Repo.get!(Edit, id)

  @doc """
  Creates a edit.

  ## Examples

      iex> create_edit(%{field: value})
      {:ok, %Edit{}}

      iex> create_edit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_edit(attrs \\ %{}) do
    %Edit{}
    |> Edit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a edit.

  ## Examples

      iex> update_edit(edit, %{field: new_value})
      {:ok, %Edit{}}

      iex> update_edit(edit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_edit(%Edit{} = edit, attrs) do
    edit
    |> Edit.changeset(attrs)
    |> Repo.update()
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

defmodule Phwiki.Wiki.Article do
  use Ecto.Schema
  import Ecto.Changeset
  import Phwiki.Slug

  schema "articles" do
    field :slug, :string
    field :title, :string

    has_many :edits, Phwiki.Wiki.Edit
    has_many :users, through: [:edits, :user]

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :slug])
    |> validate_required([:title])
    |> slugify_title()
  end

  defp slugify_title(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, new_title} -> put_change(changeset, :slug, slugify(new_title))
      :error -> changeset
    end
  end
end

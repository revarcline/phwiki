defmodule Phwiki.Wiki.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :slug, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :slug])
    |> validate_required([:title, :slug])
  end
end

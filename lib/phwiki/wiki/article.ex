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

  # defimpl Phoenix.Param, for(Phwiki.Wiki.Article) do
  # def to_param(%{slug: slug}) do
  # "#{slug}"
  # end
  # end
end

defmodule Phwiki.Repo.Migrations.IndexArticlesOnSlug do
  use Ecto.Migration

  def change do
    create(index(:articles, [:slug], unique: true))
  end
end

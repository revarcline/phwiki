defmodule Phwiki.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add(:title, :string)
      add(:slug, :citext)

      timestamps()
    end
  end
end

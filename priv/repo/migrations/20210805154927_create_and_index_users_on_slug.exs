defmodule Phwiki.Repo.Migrations.CreateAndIndexUsersOnSlug do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:slug, :string)
    end

    create(index(:users, [:slug], unique: true))
  end
end

defmodule Phwiki.Repo.Migrations.CreateEdits do
  use Ecto.Migration

  def change do
    create table(:edits) do
      add(:content, :text)
      add(:user_id, references(:users, on_delete: :nilify_all))
      add(:article_id, references(:articles, on_delete: :delete_all))

      timestamps()
    end

    create(index(:edits, [:user_id]))
    create(index(:edits, [:article_id]))
  end
end

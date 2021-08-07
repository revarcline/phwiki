defmodule Phwiki.Wiki.Edit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "edits" do
    field :content, :string

    belongs_to :user, Phwiki.Accounts.User
    belongs_to :article, Phwiki.Wiki.Article

    timestamps()
  end

  @doc false
  def changeset(edit, attrs) do
    edit
    |> cast(attrs, [:article_id, :user_id, :content])
    |> validate_required([:article_id, :user_id, :content])
  end
end

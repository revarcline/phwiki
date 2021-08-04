defmodule Phwiki.Wiki.Edit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "edits" do
    field :content, :string
    field :user_id, :id
    field :article_id, :id

    timestamps()
  end

  @doc false
  def changeset(edit, attrs) do
    edit
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end

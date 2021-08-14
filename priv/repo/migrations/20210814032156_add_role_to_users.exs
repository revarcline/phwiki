defmodule Phwiki.Repo.Migrations.AddRoleToUsers do
  use Ecto.Migration
  alias Phwiki.Accounts.User

  def change do
    User.RolesEnum.create_type()

    alter table(:users) do
      add(:role, User.RolesEnum.type())
    end
  end
end

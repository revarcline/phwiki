# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Phwiki.Repo.insert!(%Phwiki.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Phwiki.Accounts
alias Phwiki.Wiki

{:ok, admin_user} =
  Accounts.register_admin(%{
    email: "adminuser@fake.net",
    username: "Admin User",
    password: "adminpassword",
    password_confirmation: "adminpassword"
  })

{:ok, regular_user} =
  Accounts.register_user(%{
    email: "regularuser@fake.net",
    username: "Regular User",
    password: "userpassword",
    password_confirmation: "userpassword"
  })

{:ok, first_article} =
  Wiki.create_article(
    admin_user,
    %{title: "Welcome to Phwiki"},
    %{content: "Welcome to Phwiki!
    To get started, go ahead and make a few edits."}
  )

Wiki.create_article_edit(
  first_article,
  regular_user,
  %{content: "Welcome to Phwiki!
    To get started, go ahead and make a few edits or create an article."}
)

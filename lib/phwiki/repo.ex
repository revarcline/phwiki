defmodule Phwiki.Repo do
  use Ecto.Repo,
    otp_app: :phwiki,
    adapter: Ecto.Adapters.Postgres
end

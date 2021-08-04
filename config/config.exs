# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phwiki,
  ecto_repos: [Phwiki.Repo]

# Configures the endpoint
config :phwiki, PhwikiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UH5Y0QBK8gNvUXoPjIPBqTiJenQt2IAy00PMdoWzztpCkhiybZdpkuI4E3mi1YPJ",
  render_errors: [view: PhwikiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Phwiki.PubSub,
  live_view: [signing_salt: "1JW/Yh33"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cloudex,
  api_key: System.get_env("CLOUDINARY_API_KEY"),
  secret: System.get_env("CLOUDINARY_API_SECRET"),
  cloud_name: System.get_env("CLOUDINARY_CLOUD_NAME")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

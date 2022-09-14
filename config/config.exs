# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :apiconsumer,
  ecto_repos: [Apiconsumer.Repo]

config :apiconsumer, Apiconsumer.Repo,
  migration_primary_key: [type: :binary_id]

config :apiconsumer, ApiconsumerWeb.Auth.Guardian,
  issuer: "apiconsumer",
  secret_key: "1X0UoLUYs4tDhN/l3lWFsNrs6hX1gWFxzzliMf0KCYGQnq4GTysD6JIdJXA2ct/f"

config :apiconsumer, ApiconsumerWeb.Auth.Pipeline,
  module: ApiconsumerWeb.Auth.Guardian,
  error_handler: ApiconsumerWeb.Auth.ErrorHandler

# Configures the endpoint
config :apiconsumer, ApiconsumerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dYI8vdaoCEygp+bJKq9X2RN+PjftW5Jk7xUKqRHU2x1CWFxLUXLc749da9POJuts",
  render_errors: [view: ApiconsumerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Apiconsumer.PubSub,
  live_view: [signing_salt: "VjrCewOu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

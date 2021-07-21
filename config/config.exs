# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :employees_api,
  ecto_repos: [EmployeesApi.Repo]

# Configures the endpoint
config :employees_api, EmployeesApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/HpRFqasfMLljBcT/KsP123sLdhw1e8nZPv/7KrnhIZoD9sXoLoP5tcAkYnL+hal",
  render_errors: [view: EmployeesApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: EmployeesApi.PubSub,
  live_view: [signing_salt: "xp6u7DL4"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

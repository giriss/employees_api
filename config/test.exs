import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :employees_api, EmployeesApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "employees_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :employees_api, EmployeesApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "GI/pfz5MWFD/b3RS720HagLA2N4F5SzYQ6Z8UnYS84Xs5Ra7B4I/jkYYquKj7Jju",
  server: false

# In test we don't send emails.
config :employees_api, EmployeesApi.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bank_api, BankApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :bank_api, BankApi.Repo,
       username: "postgres",
       password: "postgres",
       database: "bank_api_test",
       hostname: "localhost",
       port: 5432,
       pool: Ecto.Adapters.SQL.Sandbox

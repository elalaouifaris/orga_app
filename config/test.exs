use Mix.Config

# Configure your database
config :orga_app, OrgaApp.Repo,
  username: "postgres",
  password: "postgres",
  database: "orga_app_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :orga_app, OrgaAppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

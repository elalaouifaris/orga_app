# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :orga_app,
  ecto_repos: [OrgaApp.Repo]

# Configures the endpoint
config :orga_app, OrgaAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G+uumVedmuEM/jMfcguw+KS7MzRErFWE90lVexoSFhCjxdSL6uF+1uVHSg6T96nf",
  render_errors: [view: OrgaAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OrgaApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :orga_app, :pow,
  user: OrgaApp.Users.User,
  repo: OrgaApp.Repo,
  extensions: [PowResetPassword, PowEmailConfirmation, PowInvitation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: OrgaAppWeb.PowMailer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

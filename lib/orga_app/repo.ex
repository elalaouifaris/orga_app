defmodule OrgaApp.Repo do
  use Ecto.Repo,
    otp_app: :orga_app,
    adapter: Ecto.Adapters.Postgres
end

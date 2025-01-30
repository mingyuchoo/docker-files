defmodule PhxWebApp.Repo do
  use Ecto.Repo,
    otp_app: :phx_web_app,
    adapter: Ecto.Adapters.Postgres
end

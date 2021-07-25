defmodule Vetspire.Repo do
  use Ecto.Repo,
    otp_app: :vetspire,
    adapter: Ecto.Adapters.Postgres
end

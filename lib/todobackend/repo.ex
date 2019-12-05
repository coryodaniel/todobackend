defmodule Todobackend.Repo do
  use Ecto.Repo,
    otp_app: :todobackend,
    adapter: Ecto.Adapters.Postgres
end

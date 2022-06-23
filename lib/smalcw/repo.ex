defmodule Smalcw.Repo do
  use Ecto.Repo,
    otp_app: :smalcw,
    adapter: Ecto.Adapters.Postgres
end

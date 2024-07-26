defmodule LogParser.Repo do
  use Ecto.Repo,
    otp_app: :log_parser,
    adapter: Ecto.Adapters.Postgres
end

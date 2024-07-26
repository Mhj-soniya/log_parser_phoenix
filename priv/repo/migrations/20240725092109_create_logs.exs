defmodule LogParser.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :host, :string
      add :ip, :string
      add :timestamp, :naive_datetime
      add :method, :string
      add :path, :string
      add :http_version, :string
      add :response_status, :integer
      add :response_size, :integer
      add :referer, :text
      add :user_agent, :text

      timestamps(type: :utc_datetime)
    end
  end
end

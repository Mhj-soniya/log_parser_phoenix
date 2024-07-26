defmodule LogParser.Repo.Migrations.CreateUploadedfiles do
  use Ecto.Migration

  def change do
    create table(:uploadedfiles) do
      add :file_name, :string
      add :file_hash, :string

      timestamps(type: :utc_datetime)
    end
  end
end

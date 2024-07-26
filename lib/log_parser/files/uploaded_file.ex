defmodule LogParser.Files.UploadedFile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "uploadedfiles" do
    field :file_name, :string
    field :file_hash, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(uploaded_file, attrs) do
    uploaded_file
    |> cast(attrs, [:file_name, :file_hash])
    |> validate_required([:file_name, :file_hash])
  end
end

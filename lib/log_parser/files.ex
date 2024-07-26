defmodule LogParser.Files do
  @moduledoc """
  The Files context.
  """

  import Ecto.Query, warn: false
  # alias LogParser.Files
  alias LogParser.Repo

  alias LogParser.Files.UploadedFile

  @doc """
  Returns the list of uploadedfiles.

  ## Examples

      iex> list_uploadedfiles()
      [%UploadedFile{}, ...]

  """
  def list_uploadedfiles do
    Repo.all(UploadedFile)
  end

  @doc """
  Gets a single uploaded_file.

  Raises `Ecto.NoResultsError` if the Uploaded file does not exist.

  ## Examples

      iex> get_uploaded_file!(123)
      %UploadedFile{}

      iex> get_uploaded_file!(456)
      ** (Ecto.NoResultsError)

  """
  def get_uploaded_file!(id), do: Repo.get!(UploadedFile, id)

  def get_uploaded_file_by_hash(hash_value) do
    Repo.get_by(UploadedFile, file_hash: hash_value)
  end
  @doc """
  Creates a uploaded_file.

  ## Examples

      iex> create_uploaded_file(%{field: value})
      {:ok, %UploadedFile{}}

      iex> create_uploaded_file(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_uploaded_file(attrs \\ %{}) do
    %UploadedFile{}
    |> UploadedFile.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a uploaded_file.

  ## Examples

      iex> update_uploaded_file(uploaded_file, %{field: new_value})
      {:ok, %UploadedFile{}}

      iex> update_uploaded_file(uploaded_file, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_uploaded_file(%UploadedFile{} = uploaded_file, attrs) do
    uploaded_file
    |> UploadedFile.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a uploaded_file.

  ## Examples

      iex> delete_uploaded_file(uploaded_file)
      {:ok, %UploadedFile{}}

      iex> delete_uploaded_file(uploaded_file)
      {:error, %Ecto.Changeset{}}

  """
  def delete_uploaded_file(%UploadedFile{} = uploaded_file) do
    Repo.delete(uploaded_file)
  end

  def delete_uploaded_files do
    Repo.delete_all(UploadedFile)
  end
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking uploaded_file changes.

  ## Examples

      iex> change_uploaded_file(uploaded_file)
      %Ecto.Changeset{data: %UploadedFile{}}

  """
  def change_uploaded_file(%UploadedFile{} = uploaded_file, attrs \\ %{}) do
    UploadedFile.changeset(uploaded_file, attrs)
  end
end

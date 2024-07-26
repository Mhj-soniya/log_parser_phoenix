defmodule LogParser.Parser do
  @moduledoc """
  The Parser context.
  """

  import Ecto.Query, warn: false
  alias LogParser.Repo

  alias LogParser.Parser.Log

  @doc """
  Returns the list of logs.

  ## Examples

      iex> list_logs()
      [%Log{}, ...]

  """
  def list_logs do
    Repo.all(Log)
  end

  def list_top_logs() do
    query = from l in Log, limit: 10
    Repo.all(query)
  end

  def list_filtered_logs(method) do
    query = from l in Log, where: l.method == ^method, limit: 10
    Repo.all(query)
  end

  def count_logs() do
    query = from l in Log, select: count(l.id) #returns a list
    [count] = Repo.all(query)
    count
  end

  def count_filtered_logs(method) do
    query = from l in Log, where: l.method == ^method, select: count(l.id) #returns a list
    [count] = Repo.all(query)
    count
  end

  @doc """
  Gets a single log.

  Raises `Ecto.NoResultsError` if the Log does not exist.

  ## Examples

      iex> get_log!(123)
      %Log{}

      iex> get_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_log!(id), do: Repo.get!(Log, id)

  def get_log_row(log_data) do
    Repo.get_by(Log, log_data)
  end

  @doc """
  Creates a log.

  ## Examples

      iex> create_log(%{field: value})
      {:ok, %Log{}}

      iex> create_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_log(attrs \\ %{}) do
    %Log{}
    |> Log.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a log.

  ## Examples

      iex> update_log(log, %{field: new_value})
      {:ok, %Log{}}

      iex> update_log(log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_log(%Log{} = log, attrs) do
    log
    |> Log.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a log.

  ## Examples

      iex> delete_log(log)
      {:ok, %Log{}}

      iex> delete_log(log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_log(%Log{} = log) do
    Repo.delete(log)
  end

  def delete_all_logs do
    # query = from l in Log
    Repo.delete_all(Log)
  end
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking log changes.

  ## Examples

      iex> change_log(log)
      %Ecto.Changeset{data: %Log{}}

  """
  def change_log(%Log{} = log, attrs \\ %{}) do
    Log.changeset(log, attrs)
  end
end

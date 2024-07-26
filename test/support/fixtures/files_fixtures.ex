defmodule LogParser.FilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LogParser.Files` context.
  """

  @doc """
  Generate a uploaded_file.
  """
  def uploaded_file_fixture(attrs \\ %{}) do
    {:ok, uploaded_file} =
      attrs
      |> Enum.into(%{
        file_hash: "some file_hash",
        file_name: "some file_name"
      })
      |> LogParser.Files.create_uploaded_file()

    uploaded_file
  end
end

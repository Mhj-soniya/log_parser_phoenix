defmodule LogParser.FilesTest do
  use LogParser.DataCase

  alias LogParser.Files

  describe "uploadedfiles" do
    alias LogParser.Files.UploadedFile

    import LogParser.FilesFixtures

    @invalid_attrs %{file_name: nil, file_hash: nil}

    test "list_uploadedfiles/0 returns all uploadedfiles" do
      uploaded_file = uploaded_file_fixture()
      assert Files.list_uploadedfiles() == [uploaded_file]
    end

    test "get_uploaded_file!/1 returns the uploaded_file with given id" do
      uploaded_file = uploaded_file_fixture()
      assert Files.get_uploaded_file!(uploaded_file.id) == uploaded_file
    end

    test "create_uploaded_file/1 with valid data creates a uploaded_file" do
      valid_attrs = %{file_name: "some file_name", file_hash: "some file_hash"}

      assert {:ok, %UploadedFile{} = uploaded_file} = Files.create_uploaded_file(valid_attrs)
      assert uploaded_file.file_name == "some file_name"
      assert uploaded_file.file_hash == "some file_hash"
    end

    test "create_uploaded_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Files.create_uploaded_file(@invalid_attrs)
    end

    test "update_uploaded_file/2 with valid data updates the uploaded_file" do
      uploaded_file = uploaded_file_fixture()
      update_attrs = %{file_name: "some updated file_name", file_hash: "some updated file_hash"}

      assert {:ok, %UploadedFile{} = uploaded_file} = Files.update_uploaded_file(uploaded_file, update_attrs)
      assert uploaded_file.file_name == "some updated file_name"
      assert uploaded_file.file_hash == "some updated file_hash"
    end

    test "update_uploaded_file/2 with invalid data returns error changeset" do
      uploaded_file = uploaded_file_fixture()
      assert {:error, %Ecto.Changeset{}} = Files.update_uploaded_file(uploaded_file, @invalid_attrs)
      assert uploaded_file == Files.get_uploaded_file!(uploaded_file.id)
    end

    test "delete_uploaded_file/1 deletes the uploaded_file" do
      uploaded_file = uploaded_file_fixture()
      assert {:ok, %UploadedFile{}} = Files.delete_uploaded_file(uploaded_file)
      assert_raise Ecto.NoResultsError, fn -> Files.get_uploaded_file!(uploaded_file.id) end
    end

    test "change_uploaded_file/1 returns a uploaded_file changeset" do
      uploaded_file = uploaded_file_fixture()
      assert %Ecto.Changeset{} = Files.change_uploaded_file(uploaded_file)
    end
  end
end

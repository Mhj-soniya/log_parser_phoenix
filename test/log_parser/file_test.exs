defmodule LogParser.FileTest do
  use LogParser.DataCase

  alias LogParser.File

  describe "uploadedfiles" do
    alias LogParser.File.UploadedFile

    import LogParser.FileFixtures

    @invalid_attrs %{checksum: nil, file_name: nil}

    test "list_uploadedfiles/0 returns all uploadedfiles" do
      uploaded_file = uploaded_file_fixture()
      assert File.list_uploadedfiles() == [uploaded_file]
    end

    test "get_uploaded_file!/1 returns the uploaded_file with given id" do
      uploaded_file = uploaded_file_fixture()
      assert File.get_uploaded_file!(uploaded_file.id) == uploaded_file
    end

    test "create_uploaded_file/1 with valid data creates a uploaded_file" do
      valid_attrs = %{checksum: "some checksum", file_name: "some file_name"}

      assert {:ok, %UploadedFile{} = uploaded_file} = File.create_uploaded_file(valid_attrs)
      assert uploaded_file.checksum == "some checksum"
      assert uploaded_file.file_name == "some file_name"
    end

    test "create_uploaded_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = File.create_uploaded_file(@invalid_attrs)
    end

    test "update_uploaded_file/2 with valid data updates the uploaded_file" do
      uploaded_file = uploaded_file_fixture()
      update_attrs = %{checksum: "some updated checksum", file_name: "some updated file_name"}

      assert {:ok, %UploadedFile{} = uploaded_file} = File.update_uploaded_file(uploaded_file, update_attrs)
      assert uploaded_file.checksum == "some updated checksum"
      assert uploaded_file.file_name == "some updated file_name"
    end

    test "update_uploaded_file/2 with invalid data returns error changeset" do
      uploaded_file = uploaded_file_fixture()
      assert {:error, %Ecto.Changeset{}} = File.update_uploaded_file(uploaded_file, @invalid_attrs)
      assert uploaded_file == File.get_uploaded_file!(uploaded_file.id)
    end

    test "delete_uploaded_file/1 deletes the uploaded_file" do
      uploaded_file = uploaded_file_fixture()
      assert {:ok, %UploadedFile{}} = File.delete_uploaded_file(uploaded_file)
      assert_raise Ecto.NoResultsError, fn -> File.get_uploaded_file!(uploaded_file.id) end
    end

    test "change_uploaded_file/1 returns a uploaded_file changeset" do
      uploaded_file = uploaded_file_fixture()
      assert %Ecto.Changeset{} = File.change_uploaded_file(uploaded_file)
    end
  end
end

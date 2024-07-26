defmodule LogParser.ParserTest do
  use LogParser.DataCase

  alias LogParser.Parser

  describe "logs" do
    alias LogParser.Parser.Log

    import LogParser.ParserFixtures

    @invalid_attrs %{timestamp: nil, path: nil, host: nil, ip: nil, method: nil, http_version: nil, response_status: nil, response_size: nil, referer: nil, user_agent: nil}

    test "list_logs/0 returns all logs" do
      log = log_fixture()
      assert Parser.list_logs() == [log]
    end

    test "get_log!/1 returns the log with given id" do
      log = log_fixture()
      assert Parser.get_log!(log.id) == log
    end

    test "create_log/1 with valid data creates a log" do
      valid_attrs = %{timestamp: ~N[2024-07-24 09:21:00], path: "some path", host: "some host", ip: "some ip", method: "some method", http_version: "some http_version", response_status: 42, response_size: 42, referer: "some referer", user_agent: "some user_agent"}

      assert {:ok, %Log{} = log} = Parser.create_log(valid_attrs)
      assert log.timestamp == ~N[2024-07-24 09:21:00]
      assert log.path == "some path"
      assert log.host == "some host"
      assert log.ip == "some ip"
      assert log.method == "some method"
      assert log.http_version == "some http_version"
      assert log.response_status == 42
      assert log.response_size == 42
      assert log.referer == "some referer"
      assert log.user_agent == "some user_agent"
    end

    test "create_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parser.create_log(@invalid_attrs)
    end

    test "update_log/2 with valid data updates the log" do
      log = log_fixture()
      update_attrs = %{timestamp: ~N[2024-07-25 09:21:00], path: "some updated path", host: "some updated host", ip: "some updated ip", method: "some updated method", http_version: "some updated http_version", response_status: 43, response_size: 43, referer: "some updated referer", user_agent: "some updated user_agent"}

      assert {:ok, %Log{} = log} = Parser.update_log(log, update_attrs)
      assert log.timestamp == ~N[2024-07-25 09:21:00]
      assert log.path == "some updated path"
      assert log.host == "some updated host"
      assert log.ip == "some updated ip"
      assert log.method == "some updated method"
      assert log.http_version == "some updated http_version"
      assert log.response_status == 43
      assert log.response_size == 43
      assert log.referer == "some updated referer"
      assert log.user_agent == "some updated user_agent"
    end

    test "update_log/2 with invalid data returns error changeset" do
      log = log_fixture()
      assert {:error, %Ecto.Changeset{}} = Parser.update_log(log, @invalid_attrs)
      assert log == Parser.get_log!(log.id)
    end

    test "delete_log/1 deletes the log" do
      log = log_fixture()
      assert {:ok, %Log{}} = Parser.delete_log(log)
      assert_raise Ecto.NoResultsError, fn -> Parser.get_log!(log.id) end
    end

    test "change_log/1 returns a log changeset" do
      log = log_fixture()
      assert %Ecto.Changeset{} = Parser.change_log(log)
    end
  end
end

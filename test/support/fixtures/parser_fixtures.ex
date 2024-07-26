defmodule LogParser.ParserFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LogParser.Parser` context.
  """

  @doc """
  Generate a log.
  """
  def log_fixture(attrs \\ %{}) do
    {:ok, log} =
      attrs
      |> Enum.into(%{
        host: "some host",
        http_version: "some http_version",
        ip: "some ip",
        method: "some method",
        path: "some path",
        referer: "some referer",
        response_size: 42,
        response_status: 42,
        timestamp: ~N[2024-07-24 09:21:00],
        user_agent: "some user_agent"
      })
      |> LogParser.Parser.create_log()

    log
  end
end

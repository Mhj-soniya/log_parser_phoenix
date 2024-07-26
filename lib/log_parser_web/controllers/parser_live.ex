defmodule LogParserWeb.ParserLive do
  use LogParserWeb, :live_view

  # alias LogParser.Parser
  # alias LogParser.Parser.Log

  # def mount(_params, _session, socket) do
  #   logs = Parser.list_logs()
  #   {:ok, assign(socket, logs: logs)}
  # end

  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> assign(:uploaded_files, [])
    |> allow_upload(:avatar, accept: :any, max_entries: 1)}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("upload", params, socket) do
    IO.inspect("hello")
    IO.inspect(params)
    {:noreply, assign(socket, logs: params)}
  end


end

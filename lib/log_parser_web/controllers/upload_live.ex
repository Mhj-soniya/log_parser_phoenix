defmodule LogParserWeb.UploadLive do
  use LogParserWeb, :live_view

  # alias Phoenix.LiveView.UploadConfig

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> assign(:uploaded_files, [])
    |> allow_upload(:avatar, accept: :any, max_entries: 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1>File Upload</h1>
    <div>
      <form phx-submit="upload" phx-change="validate">
        <div><.live_file_input upload={@uploads.avatar} /></div>
        <button type="submit">Upload</button>
      </form>
    </div>
    <section>
      <%= for entry <- @uploads.avatar.entries do %>
        <p><%= entry.client_name %> </p>
      <% end %>
    </section>
    """
  end

  def handle_event("validate", _params, socket) do
    # IO.inspect(params)
    {:noreply, socket}
  end

  @impl true
  def handle_event("upload", params, socket) do
    # Log file details for debugging
    IO.inspect(params, label: "Upload Params")

    # Check for the uploaded file and its properties
    # case upload_params["file"] do
    #   %Plug.Upload{filename: filename, path: path} ->
    #     IO.puts("Uploaded file: #{filename}")
    #     IO.puts("File path: #{path}")

    #     # Optionally, you can process the file here
    #     # Example: parse_and_save_file(path)

    #   _ ->
    #     IO.puts("No file uploaded or invalid file")
    # end

    {:noreply, socket}
  end
end

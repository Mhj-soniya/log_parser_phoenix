defmodule LogParserWeb.UploadController do
  use LogParserWeb, :controller

  require Logger

  alias Plug.Upload

  alias LogParser.Parser
  alias LogParser.Files
  # alias LogParser.Parser.Log


  def new(conn, _param) do
    render(conn, :new)
  end

  def index(conn, %{"method" => method}) do
      logs = Parser.list_filtered_logs(method)
      total_logs = Parser.count_filtered_logs(method)
      IO.inspect(total_logs, label: "Total number of logs")
      render(conn, :show, logs: logs, total_logs: total_logs)
  end

  def show(conn, _params) do
    logs = Parser.list_top_logs()
    total_logs = Parser.count_logs()
    IO.inspect(total_logs, label: "Total number of logs")
    render(conn, :show, logs: logs, total_logs: total_logs)
end

  def create(conn, %{"file" => %Upload{path: file_path, filename: file_name}}) do
    # IO.inspect params
    with {:ok, _file} <- File.open(file_path, [:read]) do

      # check whether file is in db or not if not then save the generated hash of file to db
      {:ok, content} = File.read(file_path)
      file_hash = :crypto.hash(:sha256, content)
                    |> Base.encode16()
                    |> String.downcase()

      IO.inspect(file_hash, label: "File hash")
      IO.inspect(Files.get_uploaded_file_by_hash(file_hash))

      case Files.get_uploaded_file_by_hash(file_hash) do
        nil ->
          Files.create_uploaded_file(%{"file_name"=>file_name, "file_hash"=>file_hash})
          conn
          |> put_flash(:info, "File uploaded")
          #insert the content of the file into logs table

          File.stream!(file_path)
            |> Enum.each(fn line -> parse_content(line) end)

          conn
            |> put_flash(:info, "File uploaded to database successfully")
            |> redirect(to: "/uploads")

        _uploaded_files ->
          conn
          |> put_flash(:error, "File already uploaded")
          |> redirect(to: "/uploads")
      end

    else
      _ ->
        conn
        |> put_flash(:error, "Failed to read file")
        |> redirect(to: "/uploads")
    end
  end

  def delete(conn, _params) do
    case Parser.delete_all_logs() do
      {0, nil} ->
        conn
        |> put_flash(:error, "Database is empty!!!")
        |> redirect(to: "/uploads")

      {_no_of_logs, nil} ->
        Files.delete_uploaded_files()
        conn
        |> put_flash(:info, "All logs successfully deleted")
        |> redirect(to: "/uploads")

    end
  end

  defp parse_content(line) do
    regex = ~r/^(?<host>[^ ]+) (?<ip>\d{1,3}(?:\.\d{1,3}){3}) [^ ]+ [^ ]+ \[(?<timestamp>[^\]]+)\] "(?<request>[^"]*)" (?<status>\d{3}) (?<size>\d+) "(?<referer>[^"]*)" "(?<user_agent>[^"]*)"/

    case Regex.named_captures(regex, line) do
      %{"host" => host, "ip" => ip, "timestamp" => timestamp_str, "request" => request, "status" => status_str, "size" => size_str, "referer" => referer, "user_agent" => user_agent} ->
        # Parse the timestamp (assuming it's in a specific format)
        timestamp = parse_timestamp(timestamp_str)

        # Convert status and size to integers
        status = String.to_integer(status_str)
        size = String.to_integer(size_str)

        # Handle possible nil values for optional fields
        {method, path, http_version} = parse_request(request)

        # Create and insert the log entry if the entry is not present in the database

        log_data = %{
          host: host,
          ip: ip,
          timestamp: timestamp,
          method: method,
          path: path,
          http_version: http_version,
          response_status: status,
          response_size: size,
          referer: referer,
          user_agent: user_agent
        }

        case Parser.get_log_row(log_data) do
          nil -> Parser.create_log(log_data)
          _ -> IO.inspect("Data present")
        end



      _ ->
        IO.puts("Line format incorrect or does not match regex: #{line}")
    end
  end

  defp parse_timestamp(datetime_str) do
    datetime_str = String.slice(datetime_str, 1, 26) # Remove the brackets
    case Timex.parse(datetime_str, "{D}/{Mshort}/{YYYY}:{h24}:{m}:{s} {Z}") do
      {:ok, datetime} -> datetime
      {:error, reason} ->
        Logger.error("Failed to parse datetime: #{datetime_str}, reason: #{inspect(reason)}")
        nil
    end
  end

  defp parse_request(request) do
    if request == "-" do
      {"-", "-", "-"}
    else
      # "GET /robots.txt HTTP/1.1"
      regex = ~r/^(?<method>[^ ]+) (?<path>[^ ]+) (?<http_version>[^ ]+)/

      case Regex.named_captures(regex, request) do
        %{"method" => method, "path" => path, "http_version" => http_version} ->
          {method, path, http_version}
        nil ->
          Logger.error("Failed to parse request: #{request}")
          {"-", "-", "-"}
      end
    end
  end

end

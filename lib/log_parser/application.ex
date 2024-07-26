defmodule LogParser.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LogParserWeb.Telemetry,
      LogParser.Repo,
      {DNSCluster, query: Application.get_env(:log_parser, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LogParser.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LogParser.Finch},
      # Start a worker by calling: LogParser.Worker.start_link(arg)
      # {LogParser.Worker, arg},
      # Start to serve requests, typically the last entry
      LogParserWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LogParser.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LogParserWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

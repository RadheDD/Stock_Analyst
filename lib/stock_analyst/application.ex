defmodule StockAnalyst.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StockAnalystWeb.Telemetry,
      StockAnalyst.Repo,
      {DNSCluster, query: Application.get_env(:stock_analyst, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: StockAnalyst.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: StockAnalyst.Finch},
      # Start a worker by calling: StockAnalyst.Worker.start_link(arg)
      # {StockAnalyst.Worker, arg},
      # Start to serve requests, typically the last entry
      StockAnalystWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StockAnalyst.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StockAnalystWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

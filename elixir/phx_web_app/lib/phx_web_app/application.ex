defmodule PhxWebApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxWebAppWeb.Telemetry,
      PhxWebApp.Repo,
      {DNSCluster, query: Application.get_env(:phx_web_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxWebApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxWebApp.Finch},
      # Start a worker by calling: PhxWebApp.Worker.start_link(arg)
      # {PhxWebApp.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxWebAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxWebApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxWebAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

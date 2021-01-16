defmodule ReservationsApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ReservationsApi.Repo,
      # Start the Telemetry supervisor
      ReservationsApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ReservationsApi.PubSub},
      # Start the Endpoint (http/https)
      ReservationsApiWeb.Endpoint
      # Start a worker by calling: ReservationsApi.Worker.start_link(arg)
      # {ReservationsApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ReservationsApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ReservationsApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

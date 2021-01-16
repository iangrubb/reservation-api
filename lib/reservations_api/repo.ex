defmodule ReservationsApi.Repo do
  use Ecto.Repo,
    otp_app: :reservations_api,
    adapter: Ecto.Adapters.Postgres
end

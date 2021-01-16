defmodule ReservationsApi.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :start, :date
      add :end, :date
      add :customer_name, :string

      timestamps()
    end
  end
end

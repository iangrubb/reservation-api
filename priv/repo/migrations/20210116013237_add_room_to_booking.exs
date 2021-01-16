defmodule ReservationsApi.Repo.Migrations.AddRoomToBooking do
  use Ecto.Migration

  def change do
    alter table(:bookings) do
      add :room_id, references("rooms")
    end
  end
end

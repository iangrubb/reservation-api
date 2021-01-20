defmodule ReservationsApi.Repo.Migrations.AddBookingConstraints do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION btree_gist")

    rename table("bookings"), :start, to: :start_date
    rename table("bookings"), :end, to: :end_date

    create constraint("bookings", :end_must_follow_start, check: "start_date < end_date")

    create constraint("bookings", :no_double_bookings,
             exclude: ~s|gist (room_id WITH =, tsrange("start_date", "end_date", '[]') WITH &&)|
           )
  end
end

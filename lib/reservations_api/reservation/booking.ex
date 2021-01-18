defmodule ReservationsApi.Reservation.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field :customer_name, :string
    field :end_date, :date
    field :start_date, :date
    belongs_to :room, ReservationsApi.Reservation.Room

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:start_date, :end_date, :customer_name, :room_id])
    |> validate_required([:start_date, :end_date, :customer_name, :room_id])
    |> assoc_constraint(:room)
    |> check_constraint(:end, name: :end_must_follow_start)
    |> exclusion_constraint(:room_id, name: :no_double_bookings)
  end
end

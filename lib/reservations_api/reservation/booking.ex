defmodule ReservationsApi.Reservation.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field :customer_name, :string
    field :end, :date
    field :start, :date

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:start, :end, :customer_name])
    |> validate_required([:start, :end, :customer_name])
  end
end

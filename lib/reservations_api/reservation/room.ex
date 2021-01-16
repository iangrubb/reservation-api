defmodule ReservationsApi.Reservation.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :floor, :integer
    field :occupancy, :integer
    field :price, :integer
    field :room_letter, :string

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:price, :occupancy, :floor, :room_letter])
    |> validate_required([:price, :occupancy, :floor, :room_letter])
  end
end

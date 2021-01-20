defmodule ReservationsApiWeb.RoomController do
  use ReservationsApiWeb, :controller

  alias ReservationsApi.Reservation
  alias ReservationsApi.Reservation.Room

  action_fallback ReservationsApiWeb.FallbackController

  def index(conn, _params) do
    rooms = Reservation.list_rooms()
    render(conn, "index.json", rooms: rooms)
  end

  def show(conn, %{"id" => id}) do
    room = Reservation.get_room!(id)
    render(conn, "show.json", room: room)
  end
end

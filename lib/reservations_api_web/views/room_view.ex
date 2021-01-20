defmodule ReservationsApiWeb.RoomView do
  use ReservationsApiWeb, :view
  alias ReservationsApiWeb.RoomView

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{
      id: room.id,
      price: room.price,
      occupancy: room.occupancy,
      room: to_string(room.floor) <> room.room_letter
    }
  end
end

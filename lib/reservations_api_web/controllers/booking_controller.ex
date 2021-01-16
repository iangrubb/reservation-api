defmodule ReservationsApiWeb.BookingController do
  use ReservationsApiWeb, :controller

  alias ReservationsApi.Reservation
  alias ReservationsApi.Reservation.Booking

  action_fallback ReservationsApiWeb.FallbackController

  def create(conn, %{"booking" => booking_params}) do
    with {:ok, %Booking{} = booking} <- Reservation.create_booking(booking_params) do
      conn
      |> put_status(:created)
      |> render("show.json", booking: booking)
    end
  end

  def update(conn, %{"id" => id, "booking" => booking_params}) do
    booking = Reservation.get_booking!(id)

    with {:ok, %Booking{} = booking} <- Reservation.update_booking(booking, booking_params) do
      render(conn, "show.json", booking: booking)
    end
  end

  def delete(conn, %{"id" => id}) do
    booking = Reservation.get_booking!(id)

    with {:ok, %Booking{}} <- Reservation.delete_booking(booking) do
      send_resp(conn, :no_content, "")
    end
  end
end

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
    with {:ok, booking} <- using_booking(id),
         {:ok, %Booking{} = booking} <- Reservation.update_booking(booking, booking_params) do
      render(conn, "show.json", booking: booking)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, booking} <- using_booking(id),
         {:ok, %Booking{}} <- Reservation.delete_booking(booking) do
      send_resp(conn, :no_content, "")
    end
  end

  defp using_booking(id) do
    case Reservation.get_booking(id) do
      nil -> {:no_referenced_entity, id}
      booking -> {:ok, booking}
    end
  end
end

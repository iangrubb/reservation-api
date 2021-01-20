defmodule ReservationsApiWeb.BookingView do
  use ReservationsApiWeb, :view
  alias ReservationsApiWeb.BookingView

  def render("index.json", %{bookings: bookings}) do
    %{data: render_many(bookings, BookingView, "booking.json")}
  end

  def render("show.json", %{booking: booking}) do
    %{data: render_one(booking, BookingView, "booking.json")}
  end

  def render("booking.json", %{booking: booking}) do
    %{
      id: booking.id,
      start_date: booking.start_date,
      end_date: booking.end_date,
      customer_name: booking.customer_name
    }
  end
end

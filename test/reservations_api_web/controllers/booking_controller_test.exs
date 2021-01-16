defmodule ReservationsApiWeb.BookingControllerTest do
  use ReservationsApiWeb.ConnCase

  alias ReservationsApi.Reservation
  alias ReservationsApi.Reservation.Booking

  @create_attrs %{
    customer_name: "some customer_name",
    end: ~D[2010-04-17],
    start: ~D[2010-04-17]
  }
  @update_attrs %{
    customer_name: "some updated customer_name",
    end: ~D[2011-05-18],
    start: ~D[2011-05-18]
  }
  @invalid_attrs %{customer_name: nil, end: nil, start: nil}

  def fixture(:booking) do
    {:ok, booking} = Reservation.create_booking(@create_attrs)
    booking
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bookings", %{conn: conn} do
      conn = get(conn, Routes.booking_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create booking" do
    test "renders booking when data is valid", %{conn: conn} do
      conn = post(conn, Routes.booking_path(conn, :create), booking: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.booking_path(conn, :show, id))

      assert %{
               "id" => id,
               "customer_name" => "some customer_name",
               "end" => "2010-04-17",
               "start" => "2010-04-17"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.booking_path(conn, :create), booking: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update booking" do
    setup [:create_booking]

    test "renders booking when data is valid", %{conn: conn, booking: %Booking{id: id} = booking} do
      conn = put(conn, Routes.booking_path(conn, :update, booking), booking: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.booking_path(conn, :show, id))

      assert %{
               "id" => id,
               "customer_name" => "some updated customer_name",
               "end" => "2011-05-18",
               "start" => "2011-05-18"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, booking: booking} do
      conn = put(conn, Routes.booking_path(conn, :update, booking), booking: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete booking" do
    setup [:create_booking]

    test "deletes chosen booking", %{conn: conn, booking: booking} do
      conn = delete(conn, Routes.booking_path(conn, :delete, booking))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.booking_path(conn, :show, booking))
      end
    end
  end

  defp create_booking(_) do
    booking = fixture(:booking)
    %{booking: booking}
  end
end

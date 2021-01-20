defmodule ReservationsApi.ReservationTest do
  use ReservationsApi.DataCase

  alias ReservationsApi.Reservation

  describe "rooms" do
    alias ReservationsApi.Reservation.Room

    @valid_attrs %{floor: 42, occupancy: 42, price: 42, room_letter: "some room_letter"}
    @update_attrs %{floor: 43, occupancy: 43, price: 43, room_letter: "some updated room_letter"}
    @invalid_attrs %{floor: nil, occupancy: nil, price: nil, room_letter: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reservation.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Reservation.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Reservation.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Reservation.create_room(@valid_attrs)
      assert room.floor == 42
      assert room.occupancy == 42
      assert room.price == 42
      assert room.room_letter == "some room_letter"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reservation.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, %Room{} = room} = Reservation.update_room(room, @update_attrs)
      assert room.floor == 43
      assert room.occupancy == 43
      assert room.price == 43
      assert room.room_letter == "some updated room_letter"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Reservation.update_room(room, @invalid_attrs)
      assert room == Reservation.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Reservation.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Reservation.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Reservation.change_room(room)
    end
  end

  describe "bookings" do
    alias ReservationsApi.Reservation.Booking

    @valid_attrs %{
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

    def booking_fixture(attrs \\ %{}) do
      {:ok, booking} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reservation.create_booking()

      booking
    end

    test "list_bookings/0 returns all bookings" do
      booking = booking_fixture()
      assert Reservation.list_bookings() == [booking]
    end

    test "get_booking!/1 returns the booking with given id" do
      booking = booking_fixture()
      assert Reservation.get_booking!(booking.id) == booking
    end

    test "create_booking/1 with valid data creates a booking" do
      assert {:ok, %Booking{} = booking} = Reservation.create_booking(@valid_attrs)
      assert booking.customer_name == "some customer_name"
      assert booking.end == ~D[2010-04-17]
      assert booking.start == ~D[2010-04-17]
    end

    test "create_booking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reservation.create_booking(@invalid_attrs)
    end

    test "update_booking/2 with valid data updates the booking" do
      booking = booking_fixture()
      assert {:ok, %Booking{} = booking} = Reservation.update_booking(booking, @update_attrs)
      assert booking.customer_name == "some updated customer_name"
      assert booking.end == ~D[2011-05-18]
      assert booking.start == ~D[2011-05-18]
    end

    test "update_booking/2 with invalid data returns error changeset" do
      booking = booking_fixture()
      assert {:error, %Ecto.Changeset{}} = Reservation.update_booking(booking, @invalid_attrs)
      assert booking == Reservation.get_booking!(booking.id)
    end

    test "delete_booking/1 deletes the booking" do
      booking = booking_fixture()
      assert {:ok, %Booking{}} = Reservation.delete_booking(booking)
      assert_raise Ecto.NoResultsError, fn -> Reservation.get_booking!(booking.id) end
    end

    test "change_booking/1 returns a booking changeset" do
      booking = booking_fixture()
      assert %Ecto.Changeset{} = Reservation.change_booking(booking)
    end
  end
end

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ReservationsApi.Repo.insert!(%ReservationsApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ReservationsApi.Reservation

Reservation.delete_rooms()

configurations = [
  %{
    occupancy: 1,
    price: 140
  },
  %{
    occupancy: 1,
    price: 240
  },
  %{
    occupancy: 2,
    price: 200
  },
  %{
    occupancy: 2,
    price: 320
  },
  %{
    occupancy: 3,
    price: 320
  },
  %{
    occupancy: 3,
    price: 400
  }
]

1..8
|> Enum.each(fn floor ->
  "ABCDEFGH"
  |> String.split("")
  |> Enum.each(fn letter ->
    configurations
    |> Enum.random()
    |> Map.put(:floor, floor)
    |> Map.put(:room_letter, letter)
    |> Reservation.create_room()
  end)
end)

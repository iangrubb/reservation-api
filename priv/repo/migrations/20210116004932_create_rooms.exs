defmodule ReservationsApi.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :price, :integer
      add :occupancy, :integer
      add :floor, :integer
      add :room_letter, :string

      timestamps()
    end

  end
end

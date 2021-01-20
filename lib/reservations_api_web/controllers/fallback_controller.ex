defmodule ReservationsApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ReservationsApiWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ReservationsApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ReservationsApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:no_referenced_entity, id}) do
    conn
    |> put_status(:not_found)
    |> put_view(ReservationsApiWeb.ChangesetView)
    |> render("error.json", error: "Requested entity with id #{id} does not exist")
  end
end

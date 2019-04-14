defmodule BankApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BankApiWeb, :controller

  alias BankApiWeb.ChangesetView
  alias BankApiWeb.ErrorView

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    send_resp(conn, 404, "")
  end

  def call(conn, {:error, error}) do
    conn
    |> put_status(:bad_request)
    |> render(ErrorView, "error.json", error: error)
  end

  def call(conn, {:errors, errors}) do
    conn
    |> put_status(:bad_request)
    |> render(ErrorView, "error.json", errors: errors)
  end

  def call(conn, nil) do
    send_resp(conn, 404, "")
  end

  def call(conn, other) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ErrorView, "error.json", error: other)
  end
end

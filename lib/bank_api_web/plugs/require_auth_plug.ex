defmodule BankApiWeb.Plugs.RequireAuth do
  @moduledoc """
  Plug that checks that there is a `Account` on the `conn` struct
  """

  import Plug.Conn

  def init(_params) do
  end

  def call(conn, _params) do
    if get_session(conn, :account_id) do
      conn
    else
      conn
      |> send_resp(401, "")
      |> halt
    end
  end
end

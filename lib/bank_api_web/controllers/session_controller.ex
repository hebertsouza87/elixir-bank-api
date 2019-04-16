defmodule BankApiWeb.SessionController do
  use BankApiWeb, :controller

  alias BankApi.Account.SignIn

  action_fallback(BankApiWeb.FallbackController)

  def create(conn, %{"account" => number, "password" => password}) do
    with {:ok, account} <- SignIn.authenticate(number, password) do
      conn
      |> put_session(:account_id, account.id)
      |> send_resp(202, "")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:account_id)
    |> send_resp(200, "")
  end
end

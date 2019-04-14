defmodule BankApiWeb.SessionController do
  use BankApiWeb, :controller

  alias BankApi.Account.SignIn

  def create(conn, params) do
    case SignIn.authenticate(
           %{
             number: params["account"],
             password: params["password"]
           }
         ) do
      nil -> conn
             |> send_resp(403, "")
      account -> conn
                 |> put_session(:user_id, account.user.id)
                 |> put_session(:account_number, account.number)
                 |> send_resp(202, "")
    end
  end
end

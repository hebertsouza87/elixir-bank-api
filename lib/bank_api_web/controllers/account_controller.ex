defmodule BankApiWeb.AccountController do
  use BankApiWeb, :controller

  alias BankApi.Account.SignUp

  def register(conn, params) do
    render(conn, "register.json", SignUp.create_account(params))
  end
end

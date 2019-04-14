defmodule BankApiWeb.AccountController do
  use BankApiWeb, :controller

  alias BankApi.Account.Accounts
  alias BankApi.Account.SignUp

  def register(conn, params) do
    render(conn, "register.json", SignUp.create_account(params))
  end

  def activate(conn, %{"account" => account_number}) do
    render(conn, "activate.json", Accounts.activate(account_number))
  end
end

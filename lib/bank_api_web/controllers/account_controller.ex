defmodule BankApiWeb.AccountController do
  use BankApiWeb, :controller

  alias BankApi.Account.Account
  alias BankApi.Account.SignUp

  def register(conn, params) do
    render(conn, "register.json", SignUp.create_account(params))
  end

  def activate(conn, %{"account" => account}) do
    account
    render(conn, "activate.json", Account.activate(account))
  end
end

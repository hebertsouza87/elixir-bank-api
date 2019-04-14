defmodule BankApiWeb.AccountController do
  use BankApiWeb, :controller

  alias BankApi.Account.Accounts
  alias BankApi.Account.SignUp

  action_fallback(BankApiWeb.FallbackController)

  def register(conn, params) do
    with {:ok, account} <- SignUp.create_account(params) do
      render(conn, "register.json", account)
    end
  end

  def activate(conn, %{"account" => account_number}) do
    with {:ok, account} <- Accounts.activate(account_number) do
      render(conn, "activate.json", account)
    end
  end

  def report(
        %{
          assigns: %{
            account: account
          }
        } = conn,

        %{"start_date" => start_date, "end_date" => end_date}
      ) do
    with {:ok, transactions} <- Accounts.report(account, start_date, end_date) do
      render(conn, "transactions.json", %{transactions: transactions})
    end
  end
end

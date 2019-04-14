defmodule BankApiWeb.TransactionController do
  use BankApiWeb, :controller

  alias BankApi.Banking.Transactions

  action_fallback(BankApiWeb.FallbackController)

  def withdraw(
        %{
          assigns: %{
            account: account
          }
        } = conn,
        %{"amount" => amount}
      ) do
    with {:ok, _} <- Transactions.withdraw(account, amount) do
      send_resp(conn, 202, "") end
  end

  def deposit(
        %{
          assigns: %{
            account: account
          }
        } = conn,
        %{"amount" => amount}
      ) do
    Transactions.deposit(account, amount)
    send_resp(conn, 202, "")
  end
end

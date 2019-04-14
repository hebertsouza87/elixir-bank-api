defmodule BankApiWeb.TransactionController do
  use BankApiWeb, :controller

  alias BankApi.Banking.Transactions

  def withdraw(
        %{
          assigns: %{
            account: account
          }
        } = conn,
        %{"amount" => amount}
      ) do
    Transactions.withdraw(account, amount)
    send_resp(conn, 202, "")
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

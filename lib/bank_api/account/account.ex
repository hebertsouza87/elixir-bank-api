defmodule BankApi.Account.Account do
  @moduledoc """
  The SignIn context of account.
  """

  alias BankApi.Account.AccountQueries
  alias BankApi.Banking.Transaction
  alias BankApi.Banking.Transactions

  def activate(account_number) do
    account_number
    |> AccountQueries.set_active()
    |> Transaction.deposit(100_000)
    |> get_account()
  end

  defp get_account(%Transactions{} = transaction) do
    transaction.account
  end
end

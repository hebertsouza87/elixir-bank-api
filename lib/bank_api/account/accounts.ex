defmodule BankApi.Account.Accounts do
  @moduledoc """
  The SignIn context of account.
  """

  alias BankApi.Account.AccountQueries
  alias BankApi.Banking.Transaction
  alias BankApi.Banking.Transactions

  def activate(account_number) do
    with {:ok, account} <- AccountQueries.set_active(account_number),
         {:ok, transaction} <- Transactions.deposit(account, 100_000) do
      {:ok, account}
    end
  end

  defp get_account(%Transaction{} = transaction) do
    transaction.account
  end
end

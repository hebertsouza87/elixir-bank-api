defmodule BankApi.Banking.Transaction do
  @moduledoc """
  The SignIn context of a transaction.
  """

  alias BankApi.Account.AccountQueries
  alias BankApi.Account.Accounts
  alias BankApi.Banking.TransactionQueries

  def deposit(nil, _) do
    nil
  end

  def deposit(%Accounts{} = account, amount) do
    TransactionQueries.insert(
      %{
        account: account,
        amount: Money.new(amount),
        type: "DEPOSIT"
      }
    )
  end
end

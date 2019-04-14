defmodule BankApi.Banking.Transactions do
  @moduledoc """
  The SignIn context of a transaction.
  """

  require Logger

  alias BankApi.Account.Account
  alias BankApi.Banking.TransactionQueries

  def deposit(nil, _) do
    nil
  end

  def deposit(%Account{} = account, amount) do
    with {:ok, amount} <- amount
                          |> Money.new()
                          |> valid_deposit(),
         {:ok, transaction} <- TransactionQueries.insert(
           %{
             account: account,
             amount: amount,
             type: "DEPOSIT"
           }
         ) do
      Logger.info("Deposit of #{Money.to_string(amount)} in account_id #{account.id}.")
      {:ok, transaction}
  end
  end

  defp valid_deposit(amount) do
    cond do
      Money.zero?(amount) -> {:error, {:amount, "No value to deposit"}}
      !Money.positive?(amount) -> {:error, {:amount, "Can`t deposit a negative value"}}
      true -> {:ok, amount}
    end
  end

  def withdraw(%Account{} = account, amount) do
    with {:ok, amount} <- amount
                          |> Money.new()
                          |> valid_withdraw(account),
         {:ok, transaction} <- TransactionQueries.insert(
           %{
             account: account,
             amount: amount,
             type: "WITHDRAW"
           }
         ) do
      Logger.info("Withdraw of #{Money.to_string(amount)} in account_id #{account.id}.")
      {:ok, transaction}
    end
    end

  defp valid_withdraw(amount, %Account{} = account) do
    cond do
      Money.zero?(amount) -> {:error, {:amount, "No value to withdraw"}}
      Money.positive?(amount) -> {:error, {:amount, "Can`t withdraw a positive value"}}
      amount
      |> Money.abs()
      |> Money.compare(get_current_amount(account.id)) == 1 -> {:error, {:amount, "Can`t withdraw more then you have"}}
      true -> {:ok, amount}
    end
  end

  defp get_current_amount(account_id) do
    account_id
    |> TransactionQueries.get_amount_in_account()
    |> Money.new()
  end
end

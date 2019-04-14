defmodule BankApi.Banking.Transactions do
  @moduledoc """
  The SignIn context of a transaction.
  """

  require Logger

  alias BankApi.Account.Account
  alias BankApi.Banking.TransactionQueries
  alias BankApi.Account.AccountQueries

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

  def transfer(%Account{} = account, amount, destination_account) do
    deposit_amount = Money.new(amount)
    withdraw_amount = Money.neg(deposit_amount)

    with {:ok, _} <- AccountQueries.find_active_by_number(destination_account),
         {:ok, amount} <- valid_withdraw(withdraw_amount, account),
         {:ok, transaction} <- TransactionQueries.insert(
           %{
             account: account,
             amount: withdraw_amount,
             type: "TRANSFER",
             destination_account: destination_account
           }
         ),
         {:ok, _} <- TransactionQueries.insert(
           %{
             account: account,
             amount: deposit_amount,
             type: "TRANSFER",
             source_account: account.number,
           }
         ) do
      Logger.info(
        "Transfer of #{Money.to_string(amount)} in account_id #{account.id} to account_number #{destination_account}."
      )
      {:ok, transaction}
    end
  end

  defp valid_deposit(amount) do
    if Money.zero?(amount) or
       !Money.positive?(amount) do
      {:error, {:amount, "Invalid amount"}}
    else
      {:ok, amount}
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
    if Money.zero?(amount) or
       Money.positive?(amount) or
       amount
       |> Money.abs()
       |> Money.compare(get_current_amount(account.id)) == 1 do
      {:error, {:amount, "Invalid amount"}}
    else
      {:ok, amount}
    end
  end

  defp get_current_amount(account_id) do
    account_id
    |> TransactionQueries.get_amount_in_account()
    |> Money.new()
  end
end

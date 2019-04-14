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
    amount = Money.new(amount)
    if Money.zero?(amount) do
      raise "No value to deposit"
    end

    if !Money.positive?(amount) do
      raise "Can`t deposit a negative value"
    end

    Logger.info("Making a deposit of #{Money.to_string(amount)} in account_id #{account.id}.")

    TransactionQueries.insert(
      %{
        account: account,
        amount: amount,
        type: "DEPOSIT"
      }
    )
  end

  def withdraw(%Account{} = account, amount) do
    amount = Money.new(amount)
    if Money.zero?(amount) do
      raise "No value to withdraw"
    end

    if Money.positive?(amount) do
      raise "Can`t withdraw a positive value"
    end

    account_amount = account.id
                     |> TransactionQueries.get_amount_in_account()
                     |> Money.new()

    if amount
       |> Money.abs()
       |> Money.compare(account_amount) == 1 do
      raise "Can`t withdraw more then you have"
    end

    Logger.info("Making a withdraw of #{Money.to_string(amount)} in account_id #{account.id}.")

    TransactionQueries.insert(
      %{
        account: account,
        amount: amount,
        type: "WITHDRAW"
      }
    )
  end
end

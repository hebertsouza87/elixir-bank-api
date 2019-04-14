defmodule BankApi.Account.Accounts do
  @moduledoc """
  The SignIn context of account.
  """

  alias BankApi.Account.Account
  alias BankApi.Account.AccountQueries
  alias BankApi.Banking.TransactionQueries
  alias BankApi.Banking.Transactions

  def activate(account_number) do
    with {:ok, account} <- AccountQueries.set_active(account_number),
         {:ok, _} <- Transactions.deposit(account, 100_000) do
      {:ok, account}
    end
  end

  def report(%Account{} = account, start_date, end_date) do
    {:ok, start_date} = Timex.parse(start_date, "{YYYY}-{0M}-{0D}")
    {:ok, end_date} = Timex.parse(end_date, "{YYYY}-{0M}-{0D}")
    end_date = Timex.end_of_day(end_date)

    with {:ok, _} <- validate_date(start_date, end_date) do
      {:ok, TransactionQueries.get_by_account_and_interval(account, start_date, end_date)}
    end
  end

  defp validate_date(start_date, end_date) do
    now = "America/Sao_Paulo"
          |> Timex.now()
          |> Timex.end_of_day

    cond do
      Timex.diff(start_date, end_date) > 0 -> {:error, start_date: "start_date is greater than end_date"}
      Timex.diff(end_date, now) > 0 -> {:error, end_date: "end_date is greater than today"}
      true -> {:ok, ""}
    end
  end
end

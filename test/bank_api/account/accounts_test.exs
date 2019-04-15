defmodule BankApi.AccountsTest do
  use BankApi.DataCase, async: false

  import BankApi.Factory

  alias BankApi.Account.Accounts
  alias BankApi.Banking.TransactionQueries

  describe "accounts" do
    test "activate/1 activate an account" do
      account = insert(:account)

      {:ok, activated_account} = Accounts.activate(account.number)
      assert activated_account.status == "ACTIVE"
      assert TransactionQueries.get_amount_in_account(activated_account.id) == 100_000
    end

    test "report/3 do not get transaction out of range" do
      today = get_today_as_string()
      yesterday = Timex.now()
                  |> Timex.shift(days: -1)

      %{account: account} = insert(:transaction, inserted_at: yesterday)
      {:ok, report} = Accounts.report(account, today, today)

      assert [] == report
    end

    test "report/3 get today report" do
      today = get_today_as_string()

      %{account: account} = insert(:transaction)
      {:ok, report} = Accounts.report(account, today, today)

      assert 1 == length(report)
    end

    test "report/3 fail when end_date is greater than today" do
      today = get_today_as_string()

      %{account: account} = insert(:transaction)

      assert Accounts.report(account, today, "3000-01-01") == {:error, {:end_date, "end_date is greater than today"}}
    end

    test "report/3 fail when start_date is greater than end_date" do
      today = get_today_as_string()

      %{account: account} = insert(:transaction)

      assert Accounts.report(account, "3000-01-01", today) == {
               :error,
               {:start_date, "start_date is greater than end_date"}
             }
    end
  end

  defp get_today_as_string do
    "America/Sao_Paulo"
    |> Timex.now()
    |> Timex.format!("{YYYY}-{0M}-{0D}")
  end
end

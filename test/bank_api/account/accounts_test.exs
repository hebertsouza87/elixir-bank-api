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

    test "report/3 get today report" do
      today = get_today_as_string()

      %{account: account} = insert(:transaction)
      {:ok, report} = Accounts.report(account, today, today)

      assert 1 == length(report)
    end

  end

  defp get_today_as_string do
    "America/Sao_Paulo"
    |> Timex.now()
    |> Timex.format!("{YYYY}-{0M}-{0D}")
  end
end

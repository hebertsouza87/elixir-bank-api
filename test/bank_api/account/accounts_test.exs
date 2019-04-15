defmodule BankApi.AccountsTest do
  use BankApi.DataCase, async: false

  import BankApi.Factory

  alias BankApi.Account.Accounts

  describe "accounts" do

    test "activate/1 activate an account" do
      account = insert(:account)

      {:ok, activated_account} = Accounts.activate(account.number)
      assert activated_account.status == "ACTIVE"
    end
  end
end

defmodule BankApiWeb.AccountView do
  use BankApiWeb, :view

  alias BankApi.Account.Account

  def render("register.json", %Account{} = account) do
    %{
      email: account.user.email,
      document: account.user.document,
      account: %{
        number: account.number
      }
    }
  end
end

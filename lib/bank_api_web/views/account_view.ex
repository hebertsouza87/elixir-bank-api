defmodule BankApiWeb.AccountView do
  use BankApiWeb, :view

  alias BankApi.Account.Account
  alias BankApi.Account.User

  def render("register.json", %Account{} = account) do
    %{
      number: account.number,
      status: account.status,
      user: %{
        email: account.user.email,
        document: account.user.document
      }
    }
  end

  def render("activate.json", %Account{} = account) do
    %{
      number: account.number,
      status: account.status
    }
  end

  def render("show.json", %User{} = user) do
    %{
      id: user.id,
      account: %{
        number: user.account.number
      }
    }
  end
end

defmodule BankApiWeb.AccountView do
  use BankApiWeb, :view

  alias BankApi.Account.Accounts
  alias BankApi.Account.Users

  def render("register.json", %Accounts{} = account) do
    %{
      number: account.number,
      status: account.status,
      user: %{
        email: account.user.email,
        document: account.user.document
      }
    }
  end

  def render("activate.json", %Accounts{} = account) do
    %{
      number: account.number,
      status: account.status
    }
  end

  def render("show.json", %Users{} = user) do
    %{
      id: user.id,
      account: %{
        number: user.account.number
      }
    }
  end
end

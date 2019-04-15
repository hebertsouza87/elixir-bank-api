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

  def render("transaction.json", %{transaction: transaction}) do
    IO.inspect(transaction)
    %{
      type: transaction.type,
      amount: to_string(transaction.amount),
      source_account: to_string(transaction.source_account),
      destination_account: to_string(transaction.destination_account),
      date: convert_date(transaction.inserted_at)
    }
  end

  def render("report.json", report) do
    %{
      transactions:
        render_many(
          report.transactions,
          BankApiWeb.AccountView,
          "transaction.json",
          as: :transaction
        ),
      total: report.transactions
             |> Enum.reduce(Money.new(0), fn %{amount: amount}, acc -> Money.add(acc, amount) end)
             |> to_string()
    }
  end

  defp convert_date(date) do
    date
    |> Timex.Timezone.convert("UTC")
    |> Timex.format!("{0D}/{0M}/{YYYY} {h24}:{m}:{s}")
  end
end

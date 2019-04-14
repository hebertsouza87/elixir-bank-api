defmodule BankApi.Banking.TransactionQueries do
  @moduledoc """
  Module to organize queries on "transactions" table
  """

  import Ecto.Query, only: [from: 2]

  alias BankApi.Banking.Transaction
  alias BankApi.Repo

  def insert(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  def get_amount_in_account(account_id) do
    query =
      from(
        t in Transaction,
        where: t.account_id == ^account_id,
        select: sum(t.amount)
      )

    Repo.one!(query)
  end
end

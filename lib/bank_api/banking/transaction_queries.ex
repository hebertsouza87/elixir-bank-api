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

  def get_by_account_and_interval(account, start_date, end_date) do
    query =
      from(
        t in Transaction,
        where: t.account_id == ^account.id,
        where: t.inserted_at >= ^start_date,
        where: t.inserted_at <= ^end_date,
        order_by: t.inserted_at
      )

    Repo.all(query)
  end
end

defmodule BankApi.Banking.TransactionQueries do
  @moduledoc """
  Module to organize queries on "transactions" table
  """

  import Ecto.Query, only: [from: 2]

  alias BankApi.Banking.Transactions
  alias BankApi.Repo

  def insert(attrs \\ %{}) do
    %Transactions{}
    |> Transactions.changeset(attrs)
    |> Repo.insert!()
  end
end

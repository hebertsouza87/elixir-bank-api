defmodule BankApi.Account.AccountQueries do
  @moduledoc """
  Module to organize queries on "accounts" table
  """

  import Ecto.Query, only: [from: 2]

  alias BankApi.Account.Accounts
  alias BankApi.Repo
  alias Ecto.Changeset

  def create(attrs \\ %{}) do
    %Accounts{}
    |> Accounts.changeset(attrs)
    |> Repo.insert!()
  end

  def find_active_by_number(number) do
    query =
      from(
        a in Accounts,
        where: a.status == ^"ACTIVE",
        where: a.number == ^number,
        preload: [:user],
        limit: 1
      )

    Repo.one!(query)
  end

  def set_active(number) do
    number
    |> find_created_by_number()
    |> Changeset.change(%{status: "ACTIVE"})
    |> Repo.update!()
  end

  def find_created_by_number(number) do
    query =
      from(
        a in Accounts,
        where: a.status == ^"CREATED",
        where: a.number == ^number,
        preload: [:user],
        limit: 1
      )

    Repo.one!(query)
  end
end

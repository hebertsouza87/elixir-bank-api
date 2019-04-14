defmodule BankApi.Account.AccountQueries do
  @moduledoc """
  Module to organize queries on "accounts" table
  """

  import Ecto.Query, only: [from: 2]

  alias BankApi.Account.Account
  alias BankApi.Repo
  alias Ecto.Changeset

  def create(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert!()
  end

  def get_active_by_id!(account_id) do
    query =
      from(
        a in Account,
        where: a.status == ^"ACTIVE",
        where: a.id == ^account_id,
        preload: [:user],
        limit: 1
      )

    Repo.one!(query)
  end

  def find_active_by_number(number) do
    query =
      from(
        a in Account,
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
        a in Account,
        where: a.status == ^"CREATED",
        where: a.number == ^number,
        preload: [:user],
        limit: 1
      )

    Repo.one!(query)
  end
end

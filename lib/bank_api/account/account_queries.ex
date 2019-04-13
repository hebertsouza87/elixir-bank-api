defmodule BankApi.Account.AccountQueries do
  @moduledoc """
  Module to organize queries on "account" table
  """
  alias BankApi.Account.Account
  alias BankApi.Repo

  def create(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert!()
  end
end

defmodule BankApi.Account.UserQueries do
  @moduledoc """
  Module to organize queries on "user" table
  """
  alias BankApi.Account.User
  alias BankApi.Repo

  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert!()
  end
end

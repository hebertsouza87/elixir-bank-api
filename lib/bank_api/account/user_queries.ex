defmodule BankApi.Account.UserQueries do
  @moduledoc """
  Module to organize queries on "users" table
  """

  alias BankApi.Account.Users
  alias BankApi.Repo

  def create(attrs \\ %{}) do
    %Users{}
    |> Users.changeset(attrs)
    |> Repo.insert!()
  end
end

defmodule BankApi.Factory do
  @moduledoc """
  Module that loads all factories used on our tests, so that when we do
  > use BankApi.Factory all of these modules will be loaded
  """

  use ExMachina.Ecto, repo: BankApi.Repo
  use BankApi.AccountFactory
end

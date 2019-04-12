defmodule BankApi.Account.SignUp do
  @moduledoc """
  Module to organize the sign up logic
  """

  alias BankApi.Account.AccountQueries
  alias BankApi.Account.UserQueries

  def create_account(params) do
    params
    |> UserQueries.create()
    |> prepare_account_attrs()
    |> AccountQueries.create()
  end

  defp prepare_account_attrs(user) do
    %{
      user: user,
      number: format_account_number(user.id),
      status: "CREATED"
    }
  end

  defp format_account_number(number) do
    number
    |> Integer.to_string
    |> String.pad_leading(8, "0")
  end
end

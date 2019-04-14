defmodule BankApi.Account.SignUp do
  @moduledoc """
  The SignUp context of account.
  """

  alias BankApi.Account.AccountQueries
  alias BankApi.Account.UserQueries

  def create_account(params) do
    with {:ok, user} <- UserQueries.create(params),
         {:ok, account} <- user
                           |> prepare_account_attrs()
                           |> AccountQueries.create() do
      {:ok, account}
    end
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

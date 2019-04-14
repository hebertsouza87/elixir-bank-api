defmodule BankApi.Account.SignIn do
  @moduledoc """
  The SignIn context of sign ir.
  """

  alias BankApi.Account.AccountQueries

  def authenticate(%{number: number, password: password}) do
    number
    |> AccountQueries.find_active_by_number()
    |> validate_password(password)
  end

  defp validate_password(nil, _) do
    nil
  end

  defp validate_password(account, password) do
    if Bcrypt.verify_pass(password, account.user.password) do
      account
    else
      nil
    end
  end
end

defmodule BankApi.Account.SignIn do
  @moduledoc """
  The SignIn context of sign ir.
  """

  alias BankApi.Account.AccountQueries

  def authenticate(%{number: number, password: password}) do
    case AccountQueries.find_active_by_number(number) do
      {:ok, account} -> validate_password(account, password)
      {:error, _} -> {:error, :forbidden}
    end
  end


  defp validate_password({:ok, account}, password) do
    if Bcrypt.verify_pass(password, account.user.password) do
      {:ok, account}
    else
      {:error, :forbidden}
    end
  end
end

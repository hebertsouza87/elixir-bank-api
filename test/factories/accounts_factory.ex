defmodule BankApi.AccountFactory do
  @moduledoc """
  Factory for modules inside the `Accounts` context
  """

  defmacro __using__(_opts) do
    quote do
      def account_factory do
        user = insert(:user)

        %BankApi.Account.Account{
          number: "00000001",
          status: "CREATED",
          user: user,
        }
      end

      def user_factory do
        %BankApi.Account.User{
          document: "11122233344",
          email: "teste@teste.com",
          name: "test name",
          password: "$2b$12$zNbJaN1s.7HQSos0xLqDEe26GvwthVkZD8gsWP555iJArQC1UvG4O",
        }
      end
    end
  end
end

defmodule BankApi.TransactionFactory do
  @moduledoc """
  Factory for modules inside the `Accounts` context
  """

  defmacro __using__(_opts) do
    quote do
      def transaction_factory do
        account = insert(:account)

        %BankApi.Banking.Transaction{
          amount: Money.new(100),
          type: "DEPOSIT",
          source_account: nil,
          destination_account: nil,
          account: account,
          inserted_at: Timex.now()
        }
      end
    end
  end
end

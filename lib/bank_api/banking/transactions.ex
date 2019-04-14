defmodule BankApi.Banking.Transactions do
  @moduledoc """
  Model to represent a Transaction.
  """
  use BankApi.Schema

  import Ecto.Changeset

  alias BankApi.Account.Accounts
  alias BankApi.Banking.Transactions

  defmodule Type do
    @moduledoc """
    Enum for an transaction type.
    """

    use Exnumerator, values: ["DEPOSIT", "WITHDRAW", "TRANSFER"]
  end

  schema "transactions" do
    field :amount, Money.Ecto.Amount.Type
    field :type, Type
    has_one :source, Accounts
    has_one :destination, Accounts
    belongs_to :account, Accounts

    timestamps()
  end

  @required_fields ~w(amount type account)a

  def changeset(%Transactions{} = transaction, attrs \\ %{}) do
    %{account: account} = attrs

    transaction
    |> cast(attrs, [:amount, :type])
    |> put_assoc(:account, account)
    |> validate_required(@required_fields)
  end
end

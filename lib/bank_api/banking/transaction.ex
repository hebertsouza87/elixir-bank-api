defmodule BankApi.Banking.Transaction do
  @moduledoc """
  Model to represent a Transaction.
  """
  use BankApi.Schema

  import Ecto.Changeset

  alias BankApi.Account.Account
  alias BankApi.Banking.Transaction

  defmodule Type do
    @moduledoc """
    Enum for an transaction type.
    """

    use Exnumerator, values: ["DEPOSIT", "WITHDRAW", "TRANSFER"]
  end

  schema "transactions" do
    field :amount, Money.Ecto.Amount.Type
    field :type, Type
    field :source_account, :string
    field :destination_account, :string
    belongs_to :account, Account

    timestamps()
  end

  @required_fields ~w(amount type account)a

  def changeset(%Transaction{} = transaction, attrs \\ %{}) do
    %{account: account} = attrs

    transaction
    |> cast(attrs, [:amount, :type, :source_account, :destination_account])
    |> put_assoc(:account, account)
    |> validate_required(@required_fields)
  end

  def report_changeset(attrs) do
    fields = [:start_date, :end_date]

    %{}
    |> cast(attrs, fields)
    |> validate_required(fields)
    |> validate_dates
  end

  defp validate_dates(changeset) do
    start_date = get_change(changeset, :start_date)
    end_date = get_change(changeset, :end_date)

    if start_date > end_date do
      add_error(changeset, :start_date, "start_date is greater than end_date")
    else
      changeset
    end
  end
end

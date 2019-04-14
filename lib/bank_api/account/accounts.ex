defmodule BankApi.Account.Accounts do
  @moduledoc """
  Model to represent a Bank Account.
  """
  use BankApi.Schema

  import Ecto.Changeset

  alias BankApi.Account.Accounts
  alias BankApi.Account.Users
  alias BankApi.Banking.Transactions

  defmodule Status do
    @moduledoc """
    Enum for an account status.
    """

    use Exnumerator, values: ["CREATED", "ACTIVE", "REMOVED"]
  end

  schema "accounts" do
    field :number, :string
    field :status, Status
    belongs_to :user, Users
    has_many(:transactions, Transactions)

    timestamps()
  end

  @required_fields ~w(number user status)a

  def changeset(%Accounts{} = account, attrs \\ %{}) do
    %{user: user} = attrs

    account
    |> cast(attrs, [:number, :status])
    |> put_assoc(:user, user)
    |> validate_required(@required_fields)
    |> unique_constraint(:number)
    |> unique_constraint(:user)
  end
end

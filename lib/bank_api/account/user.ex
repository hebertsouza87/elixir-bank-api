defmodule BankApi.Account.User do
  @moduledoc """
  Model to represent an User.
  """
  use BankApi.Schema

  import Ecto.Changeset

  alias BankApi.Account.Account
  alias BankApi.Account.User

  schema "users" do
    field :name, :string
    field :email, :string
    field :document, :string
    field :password, :string
    has_one(:account, Account)

    timestamps()
  end

  @required_fields ~w(name email document password)a

  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email, :document, :password])
    |> validate_required(@required_fields)
    |> put_downcase_email()
    |> put_password_hash()
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:document)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{
          password: password
        }
      } ->
        put_change(changeset, :password, hash_password(password))

      _ ->
        changeset
    end
  end

  defp hash_password(password) do
    Bcrypt.hash_pwd_salt(password)
  end

  defp put_downcase_email(changeset) do
    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{
          email: email
        }
      } ->
        put_change(changeset, :email, String.downcase(email))

      _ ->
        changeset
    end
  end
end

defmodule BankApi.SignUpTest do
  use BankApi.DataCase, async: false

  alias BankApi.Account.SignUp

  describe "sign up" do
    test "create_account/1 create an account" do
      request = %{
        name: "teste",
        email: "teste@teste.com",
        password: "123123",
        document: "11122233344"
      }

      {:ok, account} = SignUp.create_account(request)

      assert account.status == "CREATED"
      assert 60 = String.length(account.user.password)
    end

    test "create_account/1 fail with short password" do
      request = %{
        name: "teste",
        email: "teste@teste.com",
        password: "1234",
        document: "11122233344"
      }

      {:error, changeset} = SignUp.create_account(request)

      assert 1 = length(changeset.errors)
      assert [
               password: {"should be at least %{count} character(s)",
                 [count: 6, validation: :length, kind: :min, type: :string]
               }
             ] = changeset.errors
    end

    test "create_account/1 fail with big password" do
      request = %{
        name: "teste",
        email: "teste@teste.com",
        password: "1234567890111",
        document: "11122233344"
      }

      {:error, changeset} = SignUp.create_account(request)

      assert 1 = length(changeset.errors)
      assert [
               password: {"should be at most %{count} character(s)",
                 [count: 10, validation: :length, kind: :max, type: :string]
               }
             ] = changeset.errors
    end
  end
end

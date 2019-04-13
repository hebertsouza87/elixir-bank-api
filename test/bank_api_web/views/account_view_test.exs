defmodule BankApiWeb.AccountViewTest do
  use BankApiWeb.ConnCase, async: true

  import Phoenix.View

  alias BankApi.Account.Account
  alias BankApi.Account.User

  test "register.json" do
    now = Timex.now("America/Sao_Paulo")
    account = %Account{
      id: 2,
      inserted_at: now,
      number: "00000001",
      status: "CREATED",
      updated_at: now,
      user: %User{
        document: "11122233344",
        email: "teste@teste.com",
        id: 2,
        inserted_at: now,
        name: "test name",
        password: "$2b$12$zNbJaN1s.7HQSos0xLqDEe26GvwthVkZD8gsWP555iJArQC1UvG4O",
        updated_at: now
      },
      user_id: 1
    }

    assert render(BankApiWeb.AccountView, "register.json", account) == %{
             account: %{
               number: "00000001"
             },
             document: "11122233344",
             email: "teste@teste.com"
           }
  end
end

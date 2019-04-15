defmodule BankApiWeb.AccountViewTest do
  use BankApiWeb.ConnCase, async: true

  import Phoenix.View
  import BankApi.Factory

  test "register.json" do
    account = insert(:account)

    assert render(BankApiWeb.AccountView, "register.json", account) ==
             %{
               status: "CREATED",
               number: "00000001",
               user: %{
                 document: "11122233344",
                 email: "teste@teste.com"
               }
             }
  end
end

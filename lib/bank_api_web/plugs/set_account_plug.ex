defmodule BankApiWeb.Plugs.SetAccount do
  @moduledoc """
  Plug that sets a Account to the `conn` struct
  """

  import Plug.Conn

  alias BankApi.Account.AccountQueries
  alias Sentry.Context

  def init(_params) do
  end

  def call(conn, _params) do
    account =
      conn
      |> get_session(:account_id)
      |> AccountQueries.get_active_by_id!()

    %Timber.Contexts.UserContext{id: account.user.id, name: account.user.name, email: account.user.email}
    |> Timber.add_context()

    Context.set_user_context(account.user)
    assign(conn, :account, account)
  end
end

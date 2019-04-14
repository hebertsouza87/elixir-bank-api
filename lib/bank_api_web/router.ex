defmodule BankApiWeb.Router do
  use BankApiWeb, :router
  #  use Plug.ErrorHandler
  #  use Sentry.Plug

  pipeline :api do
    plug :accepts, ["json"]
    plug(:fetch_session)
  end

  pipeline :authenticated do
    plug(BankApiWeb.Plugs.RequireAuth)
    plug(BankApiWeb.Plugs.SetAccount)
  end

  scope "/", BankApiWeb do
    pipe_through :api

    post "/session", SessionController, :create

    post "/account", AccountController, :register
    put "/account/:account/activate", AccountController, :activate
  end

  scope "/", BankApiWeb do
    pipe_through([:api, :authenticated])

    post "/withdraw", TransactionController, :withdraw
    post "/deposit", TransactionController, :deposit
    post "/transfer", TransactionController, :transfer
    get "/report", AccountController, :report
  end
end

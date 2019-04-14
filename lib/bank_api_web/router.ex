defmodule BankApiWeb.Router do
  use BankApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug(:fetch_session)
  end

  scope "/", BankApiWeb do
    pipe_through :api

    post "/session", SessionController, :create

    post "/account", AccountController, :register
    put "/account/:account/activate", AccountController, :activate
  end
end

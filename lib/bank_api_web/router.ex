defmodule BankApiWeb.Router do
  use BankApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BankApiWeb do
    pipe_through :api

    post "/account", AccountController, :register
  end
end

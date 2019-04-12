defmodule BankApi.Schema do
  @moduledoc """
  Macro of Ecto.Schema to define a global `@timestamps_opts`.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      @timestamps_opts [type: :utc_datetime, usec: true]
    end
  end
end

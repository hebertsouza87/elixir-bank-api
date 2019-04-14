defmodule BankApiWeb.ErrorView do
  use BankApiWeb, :view
  import BankApiWeb.ErrorHelpers, only: [translate_error: 1]
  require Logger

  def render("error.json", %{error: {field, detail}}) do
    %{errors: [%{field => render_detail(detail)}]}
  end

  def render("error.json", %{error: message}) do
    %{errors: message}
  end

  def render("error.json", %{errors: errors}) do
    errors =
      Enum.map(
        errors,
        fn {field, detail} ->
          %{field => render_detail(detail)}
        end
      )

    %{errors: errors}
  end

  def render("404.json", _assigns) do
    %{
      errors: %{
        detail: "Page not found"
      }
    }
  end

  def render(
        "500.json",
        %{
          conn: %{
            assigns: reason
          }
        }
      ) do
    Logger.error(inspect(reason))
    %{
      errors: %{
        detail: "Internal server error"
      }
    }
  end

  def render("500.json", _assigns) do
    %{
      errors: %{
        detail: "Internal server error"
      }
    }
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.json", assigns)
  end

  defp render_detail({message, values}) do
    translated_error = translate_error({message, values})

    Enum.reduce(
      values,
      translated_error,
      fn {k, v}, acc ->
        String.replace(acc, "%{#{k}}", to_string(v))
      end
    )
  end

  defp render_detail(message) do
    translate_error({message, []})
  end
end

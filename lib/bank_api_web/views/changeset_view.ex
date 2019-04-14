defmodule BankApiWeb.ChangesetView do
  use BankApiWeb, :view

  alias Ecto.Changeset

  @doc """
  Traverses and translates changeset errors.

  See `Ecto.Changeset.traverse_errors/2` and
  `ApolloWeb.ErrorHelpers.translate_error/1` for more details.
  """
  def translate_errors(changeset) do
    Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}

    # ecto extract and translate the errors
    # give to function extract the details and format
    errors =
      changeset
      |> translate_errors()
      |> traverse_detail()
      |> List.flatten()

    if Map.has_key?(changeset.data, :__struct__) do
      %{errors: errors, schema: changeset.data.__struct__.__schema__(:source)}
    else
      %{errors: errors}
    end
  end

  defp traverse_detail(details) do
    Enum.map(
      details,
      fn {field, detail} ->
        cond do
          is_list(detail) -> serializer_detail({field, detail})
          is_map(detail) -> traverse_detail(detail)
          true -> %{}
        end
      end
    )
  end

  defp serializer_detail({field, detail}) do
    Enum.map(detail, fn title -> %{field => title} end)
  end
end

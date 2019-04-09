defmodule BankApi.Repo.Migrations.CreateAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :user_id, references(:users)
      add :number, :integer

      timestamps()
    end
  end
end

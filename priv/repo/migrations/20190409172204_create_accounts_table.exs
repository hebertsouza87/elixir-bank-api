defmodule BankApi.Repo.Migrations.CreateAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :user_id, references(:users)
      add :number, :string, size: 8
      add :status, :string, size: 7
      timestamps()
    end
    create unique_index(:accounts, [:number])
    create unique_index(:accounts, [:user_id])
  end
end

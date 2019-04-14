defmodule BankApi.Repo.Migrations.CreateTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :account_id, references(:accounts)
      add :amount, :integer
      add :type, :string, size: 8
      add :source_account, :string, size: 8
      add :destination_account, :string, size: 8
      timestamps()
    end
  end
end

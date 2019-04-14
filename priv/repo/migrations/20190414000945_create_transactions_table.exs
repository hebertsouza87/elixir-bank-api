defmodule BankApi.Repo.Migrations.CreateTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :account_id, references(:accounts)
      add :amount, :integer
      add :type, :string, size: 8
      add :source_id, references(:accounts)
      add :destination_id, references(:accounts)
      timestamps()
    end
  end
end

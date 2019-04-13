defmodule BankApi.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, size: 50
      add :document, :string, size: 14
      add :email, :string, size: 50
      add :password, :string, size: 60
      timestamps()
    end
    create unique_index(:users, [:document])
    create unique_index(:users, [:email])
  end
end

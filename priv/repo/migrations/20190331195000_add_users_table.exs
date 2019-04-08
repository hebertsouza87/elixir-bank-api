defmodule BankApi.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, size: 50
      add :document, :string, size: 14
      add :email, :string, size: 50
      add :password, :string, size: 50

      timestamps()
    end
  end
end

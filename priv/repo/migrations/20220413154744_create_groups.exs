defmodule SecretSanta.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string, null: false
      add :rules, :text
      add :join_code, :string, null: false

      timestamps()
    end

    create unique_index(:groups, [:join_code])
  end
end

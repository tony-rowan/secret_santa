defmodule SecretSanta.Repo.Migrations.CreateSecretSantaPairs do
  use Ecto.Migration

  def change do
    create table(:secret_santa_pairs) do
      add :user_a_id, references(:users, on_delete: :delete_all)
      add :user_b_id, references(:users, on_delete: :delete_all)
      add :group_id, references(:groups, on_delete: :delete_all)
    end

    create index(:secret_santa_pairs, [:user_a_id])
    create index(:secret_santa_pairs, [:user_b_id])
    create index(:secret_santa_pairs, [:group_id])
    create unique_index(:secret_santa_pairs, [:user_a_id, :user_b_id, :group_id])
  end
end

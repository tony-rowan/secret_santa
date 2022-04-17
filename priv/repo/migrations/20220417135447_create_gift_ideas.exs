defmodule SecretSanta.Repo.Migrations.CreateGiftIdeas do
  use Ecto.Migration

  def change do
    create table(:gift_ideas) do
      add :idea, :string, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:gift_ideas, [:user_id])
  end
end

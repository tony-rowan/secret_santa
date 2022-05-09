defmodule SecretSanta.Repo.Migrations.AddTimestampsToMappings do
  use Ecto.Migration

  def change do
    alter table("mappings") do
      timestamps()
    end
  end
end

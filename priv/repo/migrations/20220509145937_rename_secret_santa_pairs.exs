defmodule SecretSanta.Repo.Migrations.RenameSecretSantaPairs do
  use Ecto.Migration

  def change do
    rename table(:secret_santa_pairs), :user_a_id, to: :user_id
    rename table(:secret_santa_pairs), :user_b_id, to: :recipient_id
    rename table(:secret_santa_pairs), to: table(:mappings)
  end
end

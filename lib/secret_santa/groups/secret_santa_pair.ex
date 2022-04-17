defmodule SecretSanta.Groups.SecretSantaPair do
  use Ecto.Schema
  import Ecto.Changeset

  schema "secret_santa_pairs" do
    belongs_to :user_a, SecretSanta.Accounts.User
    belongs_to :user_b, SecretSanta.Accounts.User
    belongs_to :group, SecretSanta.Groups.Group
  end
end

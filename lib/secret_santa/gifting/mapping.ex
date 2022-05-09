defmodule SecretSanta.Gifting.Mapping do
  use Ecto.Schema

  schema "mappings" do
    belongs_to :user, SecretSanta.Accounts.User
    belongs_to :recipient, SecretSanta.Accounts.User
    belongs_to :group, SecretSanta.Groups.Group

    timestamps()
  end
end

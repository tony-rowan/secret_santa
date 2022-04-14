defmodule SecretSanta.Groups.GroupMembership do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group_memberships" do
    field :role, :string

    belongs_to :user, SecretSanta.Accounts.User
    belongs_to :group, SecretSanta.Groups.Group

    timestamps()
  end

  @doc false
  def changeset(group_membership, attrs) do
    group_membership
    |> cast(attrs, [:role])
    |> validate_required([:role])
  end
end

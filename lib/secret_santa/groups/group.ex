defmodule SecretSanta.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  alias SecretSanta.Gifting.Mapping
  alias SecretSanta.Groups.GroupMembership

  schema "groups" do
    field :join_code, :string
    field :name, :string
    field :rules, :string

    has_many :group_memberships, GroupMembership
    has_many :users, through: [:group_memberships, :user]
    has_many :mappings, Mapping

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :rules])
    |> validate_required([:name])
  end
end

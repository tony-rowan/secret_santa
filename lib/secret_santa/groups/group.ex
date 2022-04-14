defmodule SecretSanta.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :join_code, :string
    field :name, :string
    field :rules, :string

    has_many :group_memberships, SecretSanta.Groups.GroupMembership
    has_many :users, through: [:group_memberships, :user]

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :rules])
    |> validate_required([:name])
  end
end

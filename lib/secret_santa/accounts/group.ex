defmodule SecretSanta.Accounts.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :join_code, :string
    field :name, :string
    field :rules, :string

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :rules, :join_code])
    |> validate_required([:name, :rules, :join_code])
    |> unique_constraint(:join_code)
  end
end

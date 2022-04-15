defmodule SecretSanta.Groups.JoinRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "join_requests" do
    field :join_code, :string
  end

  @doc false
  def changeset(join_request, attrs) do
    join_request
    |> cast(attrs, [:join_code])
    |> validate_required([:join_code])
  end
end

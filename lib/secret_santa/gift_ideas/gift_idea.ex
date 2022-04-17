defmodule SecretSanta.GiftIdeas.GiftIdea do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gift_ideas" do
    field :idea, :string

    belongs_to :user, SecretSanta.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(gift_idea, attrs) do
    gift_idea
    |> cast(attrs, [:idea])
    |> validate_required([:idea])
  end
end

defmodule SecretSanta.GiftIdeas do
  @moduledoc """
  The GiftIdeas context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset

  alias SecretSanta.Repo

  alias SecretSanta.GiftIdeas.GiftIdea

  def empty_changeset() do
    GiftIdea.changeset(%GiftIdea{}, %{})
  end

  def list_gift_ideas_for_user(user) do
    Repo.all(from gift_idea in GiftIdea, where: gift_idea.user_id == ^user.id)
  end

  def create_gift_idea(user, gift_idea_attrs) do
    GiftIdea.changeset(%GiftIdea{}, gift_idea_attrs)
    |> put_change(:user_id, user.id)
    |> Repo.insert()
  end
end

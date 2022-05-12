defmodule SecretSanta.GiftIdeasFixtures do
  alias SecretSanta.GiftIdeas

  def gift_idea_fixture(attrs \\ %{}) do
    {user, attrs} = Map.pop(attrs, :user, SecretSanta.AccountsFixtures.user_fixture())

    {:ok, gift_idea} = GiftIdeas.create_gift_idea(user, Enum.into(attrs, %{idea: "some idea"}))

    gift_idea
  end
end

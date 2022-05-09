defmodule SecretSanta.GiftIdeasTest do
  use SecretSanta.DataCase

  alias SecretSanta.GiftIdeas

  describe "gift_ideas" do
    alias SecretSanta.GiftIdeas.GiftIdea

    import SecretSanta.GiftIdeasFixtures

    @valid_attrs %{idea: "Chocolate"}
    @invalid_attrs %{idea: nil}

    test "get_gift_idea!/1 returns the gift_idea with given id" do
      gift_idea = gift_idea_fixture()
      assert GiftIdeas.get_gift_idea!(gift_idea.id) == gift_idea
    end

    test "list_gift_ideas_for_user/1 returns all gift ideas for the given user" do
      user = SecretSanta.AccountsFixtures.user_fixture()
      gift_idea_1 = gift_idea_fixture(%{user: user})
      gift_idea_2 = gift_idea_fixture(%{user: user})
      assert GiftIdeas.list_gift_ideas_for_user(user) == [gift_idea_1, gift_idea_2]
    end

    test "list_gift_ideas_for_user/1 does not return gift ideas for other users" do
      user_1 = SecretSanta.AccountsFixtures.user_fixture()
      user_2 = SecretSanta.AccountsFixtures.user_fixture()
      gift_idea_1 = gift_idea_fixture(%{user: user_1})
      gift_idea_2 = gift_idea_fixture(%{user: user_2})
      assert GiftIdeas.list_gift_ideas_for_user(user_1) == [gift_idea_1]
      assert GiftIdeas.list_gift_ideas_for_user(user_2) == [gift_idea_2]
    end

    test "create_gift_idea/1 with valid data creates a gift_idea" do
      user = SecretSanta.AccountsFixtures.user_fixture()
      assert {:ok, %GiftIdea{idea: "Chocolate"}} = GiftIdeas.create_gift_idea(user, @valid_attrs)
    end

    test "create_gift_idea/1 with invalid data returns error changeset" do
      user = SecretSanta.AccountsFixtures.user_fixture()
      assert {:error, %Ecto.Changeset{}} = GiftIdeas.create_gift_idea(user, @invalid_attrs)
    end

    test "delete_gift_idea/1 deletes the gift_idea" do
      gift_idea = gift_idea_fixture()
      assert {:ok, %GiftIdea{}} = GiftIdeas.delete_gift_idea(gift_idea)
      assert_raise Ecto.NoResultsError, fn -> GiftIdeas.get_gift_idea!(gift_idea.id) end
    end
  end
end

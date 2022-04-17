defmodule SecretSanta.GiftIdeasTest do
  use SecretSanta.DataCase

  alias SecretSanta.GiftIdeas

  describe "gift_ideas" do
    alias SecretSanta.GiftIdeas.GiftIdea

    import SecretSanta.GiftIdeasFixtures

    @invalid_attrs %{idea: nil}

    test "list_gift_ideas/0 returns all gift_ideas" do
      gift_idea = gift_idea_fixture()
      assert GiftIdeas.list_gift_ideas() == [gift_idea]
    end

    test "get_gift_idea!/1 returns the gift_idea with given id" do
      gift_idea = gift_idea_fixture()
      assert GiftIdeas.get_gift_idea!(gift_idea.id) == gift_idea
    end

    test "create_gift_idea/1 with valid data creates a gift_idea" do
      valid_attrs = %{idea: "some idea"}

      assert {:ok, %GiftIdea{} = gift_idea} = GiftIdeas.create_gift_idea(valid_attrs)
      assert gift_idea.idea == "some idea"
    end

    test "create_gift_idea/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GiftIdeas.create_gift_idea(@invalid_attrs)
    end

    test "update_gift_idea/2 with valid data updates the gift_idea" do
      gift_idea = gift_idea_fixture()
      update_attrs = %{idea: "some updated idea"}

      assert {:ok, %GiftIdea{} = gift_idea} = GiftIdeas.update_gift_idea(gift_idea, update_attrs)
      assert gift_idea.idea == "some updated idea"
    end

    test "update_gift_idea/2 with invalid data returns error changeset" do
      gift_idea = gift_idea_fixture()
      assert {:error, %Ecto.Changeset{}} = GiftIdeas.update_gift_idea(gift_idea, @invalid_attrs)
      assert gift_idea == GiftIdeas.get_gift_idea!(gift_idea.id)
    end

    test "delete_gift_idea/1 deletes the gift_idea" do
      gift_idea = gift_idea_fixture()
      assert {:ok, %GiftIdea{}} = GiftIdeas.delete_gift_idea(gift_idea)
      assert_raise Ecto.NoResultsError, fn -> GiftIdeas.get_gift_idea!(gift_idea.id) end
    end

    test "change_gift_idea/1 returns a gift_idea changeset" do
      gift_idea = gift_idea_fixture()
      assert %Ecto.Changeset{} = GiftIdeas.change_gift_idea(gift_idea)
    end
  end
end

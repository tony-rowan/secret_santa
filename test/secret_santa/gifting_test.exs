defmodule SecretSanta.GiftingTest do
  use SecretSanta.DataCase

  alias SecretSanta.Gifting

  alias SecretSanta.AccountsFixtures
  alias SecretSanta.GroupsFixtures

  describe "mappings" do
    test "start_secret_santa/1 assigns non-self mappings to each user" do
      admin_0 = AccountsFixtures.user_fixture()
      member_1 = AccountsFixtures.user_fixture()
      member_2 = AccountsFixtures.user_fixture()
      group = GroupsFixtures.group_fixture(%{admin: admin_0, members: [member_1, member_2]})

      {:ok, group} = Gifting.start_secret_santa(group)

      refute Enum.any?(group.mappings, fn mapping -> mapping.user == mapping.recipient end)
    end

    # this isn't very _secret_ santa, but I feel like it should work anyway
    test "start_secret_santa/1 works with only two members" do
      admin_0 = AccountsFixtures.user_fixture()
      member_1 = AccountsFixtures.user_fixture()
      group = GroupsFixtures.group_fixture(%{admin: admin_0, members: [member_1]})

      {:ok, group} = Gifting.start_secret_santa(group)

      refute Enum.any?(group.mappings, fn mapping -> mapping.user == mapping.recipient end)
    end

    # I don't even know why you would do this, but I suppose it shouldn't crash if you do
    test "start_secret_santa/1 works with only one member" do
      admin_0 = AccountsFixtures.user_fixture()
      group = GroupsFixtures.group_fixture(%{admin: admin_0})

      {:ok, group} = Gifting.start_secret_santa(group)

      assert Enum.count(group.mappings) == 1
      assert List.first(group.mappings).user_id == List.first(group.mappings).recipient_id
    end
  end
end

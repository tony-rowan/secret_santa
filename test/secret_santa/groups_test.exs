defmodule SecretSanta.GroupsTest do
  use SecretSanta.DataCase

  alias SecretSanta.Groups

  describe "groups" do
    alias SecretSanta.Groups.Group

    import SecretSanta.GroupsFixtures

    @invalid_attrs %{name: nil, rules: nil}

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Groups.get_group!(group.id) |> SecretSanta.Repo.preload(:group_memberships) == group
    end

    test "create_group/1 with valid data creates a group" do
      user = SecretSanta.AccountsFixtures.user_fixture()
      valid_attrs = %{name: "Group Name", rules: "Group Rules"}

      assert {:ok, %Group{name: "Group Name", rules: "Group Rules"}} =
               Groups.create_group(user, valid_attrs)
    end

    test "create_group/1 with invalid data returns error changeset" do
      user = SecretSanta.AccountsFixtures.user_fixture()
      assert {:error, %Ecto.Changeset{}} = Groups.create_group(user, @invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      update_attrs = %{name: "Updated Name", rules: "Updated Rules"}

      assert {:ok, %Group{name: "Updated Name", rules: "Updated Rules"}} =
               Groups.update_group(group, update_attrs)
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Groups.update_group(group, @invalid_attrs)
      assert group == Groups.get_group!(group.id) |> SecretSanta.Repo.preload(:group_memberships)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Groups.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Groups.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Groups.change_group(group)
    end
  end

  describe "group_memberships" do
  end
end

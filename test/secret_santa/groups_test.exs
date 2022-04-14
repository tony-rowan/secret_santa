defmodule SecretSanta.GroupsTest do
  use SecretSanta.DataCase

  alias SecretSanta.Groups

  describe "group_memberships" do
    alias SecretSanta.Groups.GroupMembership

    import SecretSanta.GroupsFixtures

    @invalid_attrs %{role: nil}

    test "list_group_memberships/0 returns all group_memberships" do
      group_membership = group_membership_fixture()
      assert Groups.list_group_memberships() == [group_membership]
    end

    test "get_group_membership!/1 returns the group_membership with given id" do
      group_membership = group_membership_fixture()
      assert Groups.get_group_membership!(group_membership.id) == group_membership
    end

    test "create_group_membership/1 with valid data creates a group_membership" do
      valid_attrs = %{role: "some role"}

      assert {:ok, %GroupMembership{} = group_membership} = Groups.create_group_membership(valid_attrs)
      assert group_membership.role == "some role"
    end

    test "create_group_membership/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Groups.create_group_membership(@invalid_attrs)
    end

    test "update_group_membership/2 with valid data updates the group_membership" do
      group_membership = group_membership_fixture()
      update_attrs = %{role: "some updated role"}

      assert {:ok, %GroupMembership{} = group_membership} = Groups.update_group_membership(group_membership, update_attrs)
      assert group_membership.role == "some updated role"
    end

    test "update_group_membership/2 with invalid data returns error changeset" do
      group_membership = group_membership_fixture()
      assert {:error, %Ecto.Changeset{}} = Groups.update_group_membership(group_membership, @invalid_attrs)
      assert group_membership == Groups.get_group_membership!(group_membership.id)
    end

    test "delete_group_membership/1 deletes the group_membership" do
      group_membership = group_membership_fixture()
      assert {:ok, %GroupMembership{}} = Groups.delete_group_membership(group_membership)
      assert_raise Ecto.NoResultsError, fn -> Groups.get_group_membership!(group_membership.id) end
    end

    test "change_group_membership/1 returns a group_membership changeset" do
      group_membership = group_membership_fixture()
      assert %Ecto.Changeset{} = Groups.change_group_membership(group_membership)
    end
  end
end

defmodule SecretSanta.GroupsFixtures do
  alias SecretSanta.Groups

  def group_fixture(attrs \\ %{}) do
    {admin, attrs} = Map.pop(attrs, :admin, SecretSanta.AccountsFixtures.user_fixture())
    {members, attrs} = Map.pop(attrs, :members, [])

    {:ok, group} =
      Groups.create_group(
        admin,
        Enum.into(attrs, %{
          name: "Group Name",
          rules: "Group Rules"
        })
      )

    for member <- members, do: Groups.create_group_membership(group, member)

    group
  end
end

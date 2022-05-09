defmodule SecretSanta.GroupsFixtures do

  alias SecretSanta.Groups

  def group_fixture(attrs \\ %{}) do
    {admin, attrs} = Map.pop(attrs, :admin, SecretSanta.AccountsFixtures.user_fixture())

    {:ok, group} =
      Groups.create_group(admin, Enum.into(attrs, %{
        name: "Group Name",
        rules: "Group Rules"
      }))

    group
  end
end

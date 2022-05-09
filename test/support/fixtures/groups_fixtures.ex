defmodule SecretSanta.GroupsFixtures do

  alias SecretSanta.Groups

  def unique_group_join_code, do: "join_code_#{System.unique_integer([:positive])}"

  def group_fixture(attrs \\ %{}) do
    user = SecretSanta.AccountsFixtures.user_fixture()

    {:ok, group} =
      Groups.create_group(user, Enum.into(attrs, %{
        join_code: unique_group_join_code(),
        name: "Group Name",
        rules: "Group Rules"
      }))

    group
  end
end

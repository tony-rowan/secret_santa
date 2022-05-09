defmodule SecretSanta.Gifting do
  import Ecto.Query, warn: false
  import Ecto.Changeset

  alias SecretSanta.Gifting.Mapping
  alias SecretSanta.Groups.{Group, GroupMembership}
  alias SecretSanta.Repo

  def start_secret_santa(%Group{} = group) do
    group = group |> Repo.preload(:mappings)
    mappings = group |> get_randomly_ordered_group_members() |> generate_mappings()
    insert_mappings(group, mappings)
  end

  defp get_randomly_ordered_group_members(group) do
    Repo.all(
      from group_membership in GroupMembership,
      where: group_membership.group_id == ^group.id,
      order_by: fragment("RANDOM()"),
      select: group_membership.user_id
    )
  end

  defp generate_mappings(group_member_ids) do
    group_member_ids
    |> Enum.zip([List.last(group_member_ids) | group_member_ids])
    |> Enum.map(fn {from, to} -> %Mapping{user_id: from, recipient_id: to} end)
  end

  defp insert_mappings(group, mappings) do
    Group.changeset(group, %{})
    |> put_assoc(:mappings, mappings)
    |> Repo.update()
  end
end

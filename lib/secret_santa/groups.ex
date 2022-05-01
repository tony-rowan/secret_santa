defmodule SecretSanta.Groups do
  @moduledoc """
  The Groups context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset

  alias SecretSanta.Repo

  alias SecretSanta.Groups.Group
  alias SecretSanta.Groups.GroupMembership
  alias SecretSanta.Groups.JoinRequest
  alias SecretSanta.Groups.SecretSantaPair

  def load_group_members(group) do
    group |> Repo.preload(:users)
  end

  def load_group_memberships(group) do
    group |> Repo.preload(:group_memberships) |> Repo.preload(:users)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  def get_group_by_join_code(join_code) do
    Repo.get_by(Group, join_code: join_code)
  end

  def get_group_for_user(user) do
    Repo.one(from group in Group,
      join: membership in GroupMembership,
      on: membership.group_id == group.id,
      where: membership.user_id == ^user.id,
      order_by: membership.inserted_at,
      limit: 1
    )
  end

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(user, attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> put_change(:join_code, SecureRandom.hex(6))
    |> put_assoc(:group_memberships, [%GroupMembership{user_id: user.id, role: "admin"}])
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end

  def change_join_request(%JoinRequest{} = join_request, attrs \\ %{}) do
    JoinRequest.changeset(join_request, attrs)
  end

  def join_group(user, %{"join_code" => join_code} = join_request_attrs) do
    group = get_group_by_join_code(join_code)

    if group do
      attrs = %{"user_id" => user.id, "group_id" => group.id, "role" => "member"}

      GroupMembership.changeset(%GroupMembership{}, attrs)
      |> Repo.insert()
    else
      changeset =
        change_join_request(%JoinRequest{}, join_request_attrs)
        |> add_error(:join_code, "Join Code '%{join_code}' is not valid", join_code: join_code)
      {:error, %{changeset | action: :insert}}
    end
  end

  def user_is_group_admin?(nil, _group), do: false

  def user_is_group_admin?(_user, nil), do: false

  def user_is_group_admin?(user, group) do
    Repo.exists?(
      from group_membership in GroupMembership,
      where: group_membership.user_id == ^user.id,
      where: group_membership.group_id == ^group.id,
      where: group_membership.role == "admin"
    )
  end

  def get_secret_santa_for_user(nil, _group), do: false

  def get_secret_santa_for_user(_user, nil), do: false

  def get_secret_santa_for_user(user, group) do
    pairing = Repo.one(
      from pair in SecretSantaPair,
      where: pair.group_id == ^group.id,
      where: pair.user_a_id == ^user.id,
      preload: [user_b: [:gift_ideas]]
    )

    if pairing do
      pairing.user_b
    else
      nil
    end
  end

  def start_secret_santa(group) do
    user_ids = Repo.all(
      from group_membership in GroupMembership,
      where: group_membership.group_id == ^group.id,
      order_by: fragment("RANDOM()"),
      select: group_membership.user_id
    )

    id_pairs = Enum.zip(user_ids, [List.last(user_ids) | user_ids])
    pairs = id_pairs |> Enum.map fn {a, b} ->
      %SecretSantaPair{user_a_id: a, user_b_id: b, group_id: group.id}
    end

    Group.changeset(group, %{})
    |> put_assoc(:secret_santa_pairs, pairs)
    |> Repo.update()
  end
end

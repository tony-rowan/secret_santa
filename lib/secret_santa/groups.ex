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
    Repo.one(from Group,
      join: membership in GroupMembership,
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
      %GroupMembership{}
      |> GroupMembership.changeset(attrs)
      |> Repo.insert()
    else
      changeset =
        change_join_request(%JoinRequest{}, join_request_attrs)
        |> add_error(:join_code, "Join Code '%{join_code}' is not valid", join_code: join_code)
      {:error, changeset}
    end
  end
end

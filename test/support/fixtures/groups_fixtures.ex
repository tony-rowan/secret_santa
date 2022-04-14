defmodule SecretSanta.GroupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SecretSanta.Groups` context.
  """

  @doc """
  Generate a group_membership.
  """
  def group_membership_fixture(attrs \\ %{}) do
    {:ok, group_membership} =
      attrs
      |> Enum.into(%{
        role: "some role"
      })
      |> SecretSanta.Groups.create_group_membership()

    group_membership
  end
end

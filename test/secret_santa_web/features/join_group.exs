defmodule SecretSantaWeb.JoinGroupTest do
  use SecretSanta.FixtureCase

  @group_attrs %{
    name: "Nice List",
    rules: "Be good, or you get coal instead of presents!"
  }

  feature "user joins a group", %{session: session} do
    group = SecretSanta.GroupsFixtures.group_fixture(@group_attrs)

    session
    |> log_in()
    |> visit("/home")
    |> click(link("Join a Group"))
    |> fill_in(text_field("Join code"), with: group.join_code)
    |> click(button("Join Group"))
    |> assert_has_text("You are part of the #{@group_attrs[:name]} secret santa group")
    |> assert_has(Query.text(@group_attrs[:rules]))
    |> assert_has(link(@group_attrs[:name]))
  end
end

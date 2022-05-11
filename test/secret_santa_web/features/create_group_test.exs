defmodule SecretSantaWeb.CreateGroupTest do
  use SecretSanta.FixtureCase

  @group_attrs %{
    name: "Nice List",
    rules: "Be good, or you get coal instead of presents!"
  }

  feature "user creates a group", %{session: session} do
    session
    |> log_in()
    |> visit("/home")
    |> click(link("Create a Group"))
    |> fill_in(text_field("Name"), with: @group_attrs[:name])
    |> fill_in(text_field("Rules"), with: @group_attrs[:rules])
    |> click(button("Create"))
    |> assert_has_text("You are part of the #{@group_attrs[:name]} secret santa group")
    |> assert_has(Query.text(@group_attrs[:rules]))
    |> assert_has(link(@group_attrs[:name]))
  end
end

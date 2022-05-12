defmodule SecretSantaWeb.JoinGroupTest do
  use SecretSanta.FixtureCase

  @user_attrs %{
    name: "Niklaus",
    email: "niklaus@gmail.com",
    password: "password"
  }
  @group_attrs %{
    name: "Nice List",
    rules: "Be good, or you get coal instead of presents!"
  }

  feature "user joins a group after logging in", %{session: session} do
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

  feature "user joins group as part of registration", %{session: session} do
    group = SecretSanta.GroupsFixtures.group_fixture(@group_attrs)

    session
    |> visit("/join/#{group.join_code}")
    |> fill_in(text_field("Name"), with: @user_attrs[:name])
    |> fill_in(text_field("Email"), with: @user_attrs[:email])
    |> fill_in(text_field("Password"), with: @user_attrs[:password])
    |> click(button("Register"))
    |> assert_has_text("You are part of the #{@group_attrs[:name]} secret santa group")
    |> assert_has(Query.text(@group_attrs[:rules]))
    |> assert_has(link(@group_attrs[:name]))
  end
end

defmodule SecretSantaWeb.WelcomeTest do
  use SecretSanta.FixtureCase

  import SecretSanta.AccountsFixtures
  import SecretSanta.GroupsFixtures

  @user_attributes %{name: "Niklaus", email: "niklaus@gmail.com", password: "password"}

  feature "user without a group logs in", %{session: session} do
    user_fixture(@user_attributes)

    session
    |> visit("/")
    |> click(link("Log In"))
    |> fill_in(text_field("Email"), with: @user_attributes[:email])
    |> fill_in(text_field("Password"), with: @user_attributes[:password])
    |> click(button("Log In"))
    |> assert_has(link(@user_attributes[:name]))
    |> assert_has(link("Join a Group"))
    |> assert_has(link("Create a Group"))
  end

  feature "user with a group logs in", %{session: session} do
    user = user_fixture(@user_attributes)
    group_fixture(%{admin: user, name: "Nice List"})

    session
    |> visit("/")
    |> click(link("Log In"))
    |> fill_in(text_field("Email"), with: @user_attributes[:email])
    |> fill_in(text_field("Password"), with: @user_attributes[:password])
    |> click(button("Log In"))
    |> assert_has(link(@user_attributes[:name]))
    |> assert_has_text("You are part of the Nice List secret santa group")
  end

  feature "user registers for an account", %{session: session} do
    session
    |> visit("/")
    |> click(link("Register"))
    |> fill_in(text_field("Name"), with: @user_attributes[:name])
    |> fill_in(text_field("Email"), with: @user_attributes[:email])
    |> fill_in(text_field("Password"), with: @user_attributes[:password])
    |> click(button("Register"))
    |> assert_has(link(@user_attributes[:name]))
    |> assert_has(link("Join a Group"))
    |> assert_has(link("Create a Group"))
  end
end

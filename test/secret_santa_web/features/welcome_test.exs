defmodule SecretSantaWeb.WelcomeTest do
  use SecretSanta.FixtureCase

  feature "user without a group logs in", %{session: session} do
    SecretSanta.AccountsFixtures.user_fixture(
      %{name: "Niklaus", email: "niklaus@gmail.com", password: "password"}
    )

    session
    |> visit("/")
    |> click(link("Log In"))
    |> fill_in(text_field("Email"), with: "niklaus@gmail.com")
    |> fill_in(text_field("Password"), with: "password")
    |> click(button("Log In"))
    |> assert_has(link("Niklaus"))
    |> assert_has(link("Join a Group"))
    |> assert_has(link("Create a Group"))
  end

  feature "user with a group logs in", %{session: session} do
    user = SecretSanta.AccountsFixtures.user_fixture(
      %{name: "Niklaus", email: "niklaus@gmail.com", password: "password"}
    )
    SecretSanta.GroupsFixtures.group_fixture(%{admin: user, name: "Nice List"})

    session
    |> visit("/")
    |> click(link("Log In"))
    |> fill_in(text_field("Email"), with: "niklaus@gmail.com")
    |> fill_in(text_field("Password"), with: "password")
    |> click(button("Log In"))
    |> assert_has(link("Niklaus"))
    |> assert_has_text("You are part of the Nice List secret santa group")
  end

  feature "user registers for an account", %{session: session} do
    session
    |> visit("/")
    |> click(link("Register"))
    |> fill_in(text_field("Name"), with: "Niklaus")
    |> fill_in(text_field("Email"), with: "niklaus@gmail.com")
    |> fill_in(text_field("Password"), with: "password")
    |> click(button("Register"))
    |> assert_has(link("Join a Group"))
    |> assert_has(link("Create a Group"))
  end
end

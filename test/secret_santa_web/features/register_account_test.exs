defmodule SecretSantaWeb.RegisterAccountTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Query

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

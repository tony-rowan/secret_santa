defmodule SecretSanta.FixtureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use ExUnit.Case, async: true
      use Wallaby.Feature

      import Wallaby.Query
      import SecretSanta.FixtureCase
    end
  end

  alias Wallaby.Browser
  alias Wallaby.Query

  import SecretSanta.AccountsFixtures

  def log_in(session) do
    email = unique_user_email()
    password = valid_user_password()
    user_fixture(%{email: email, password: password})
    log_in(session, email, password)
  end

  def log_in(session, email, password) do
    session
    |> Browser.visit("users/log_in")
    |> Browser.fill_in(Query.text_field("Email"), with: email)
    |> Browser.fill_in(Query.text_field("Password"), with: password)
    |> Browser.click(Query.button("Log In"))
  end

  def print_page_text(session) do
    session |> Browser.text() |> IO.inspect()
    session
  end

  # Helper that still works if the text to find includes text in a span
  # TODO: Work out how to make this wait
  # TODO: Raise as an issue with Wallaby
  def assert_has_text(session, text) do
    page_text = session |> Browser.text()
    assert page_text =~ text
    session
  end
end

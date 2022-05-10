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

  def print_page_text(session) do
    session |> Wallaby.Browser.text() |> IO.inspect()
    session
  end

  # Helper that still works if the text to find includes text in a span
  # TODO: Work out how to make this wait
  # TODO: Raise as an issue with Wallaby
  def assert_has_text(session, text) do
    page_text = session |> Wallaby.Browser.text()
    assert page_text =~ text
    session
  end
end

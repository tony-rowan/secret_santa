defmodule SecretSanta.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SecretSanta.Accounts` context.
  """

  def user_name, do: "John #{System.unique_integer()} Doe"
  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: user_name(),
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> SecretSanta.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a unique group join_code.
  """
  def unique_group_join_code, do: "some join_code#{System.unique_integer([:positive])}"

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        join_code: unique_group_join_code(),
        name: "some name",
        rules: "some rules"
      })
      |> SecretSanta.Accounts.create_group()

    group
  end
end

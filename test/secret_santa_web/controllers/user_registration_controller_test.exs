defmodule SecretSantaWeb.UserRegistrationControllerTest do
  use SecretSantaWeb.ConnCase, async: true

  import SecretSanta.AccountsFixtures

  describe "GET /users/register" do
    test "renders registration page", %{conn: conn} do
      conn = get(conn, Routes.user_registration_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "Create Account"
      assert response =~ "Register"
      assert response =~ "Have an Account?"
    end

    test "redirects if already logged in", %{conn: conn} do
      conn = conn |> log_in_user(user_fixture()) |> get(Routes.user_registration_path(conn, :new))
      assert redirected_to(conn) == Routes.home_path(conn, :show)
    end
  end

  describe "POST /users/register" do
    @tag :capture_log
    test "creates account and logs the user in", %{conn: conn} do
      name = "User Name"

      conn =
        post(conn, Routes.user_registration_path(conn, :create), %{
          "user" => valid_user_attributes(name: name)
        })

      assert get_session(conn, :user_token)
      assert redirected_to(conn) == Routes.home_path(conn, :show)

      # Now do a logged in request and assert on the menu
      conn = get(conn, Routes.home_path(conn, :show))
      response = html_response(conn, 200)
      assert response =~ name
    end

    test "render errors for invalid data", %{conn: conn} do
      conn =
        post(conn, Routes.user_registration_path(conn, :create), %{
          "user" => %{"email" => "with spaces", "password" => "short"}
        })

      response = html_response(conn, 200)
      assert response =~ "Register"
      assert response =~ "must have the @ sign and no spaces"
      assert response =~ "should be at least 6 character(s)"
    end
  end
end

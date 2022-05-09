defmodule SecretSantaWeb.GiftIdeaControllerTest do
  use SecretSantaWeb.ConnCase

  import SecretSanta.GiftIdeasFixtures

  setup :setup_member_user

  @create_attrs %{idea: "Some Gift Idea"}
  @invalid_attrs %{idea: nil}

  describe "create gift_idea" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.gift_idea_path(conn, :create), gift_idea: @create_attrs)

      assert redirected_to(conn) == Routes.home_path(conn, :show)

      conn = get(conn, Routes.home_path(conn, :show))

      assert html_response(conn, 200) =~ "Some Gift Idea"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.gift_idea_path(conn, :create), gift_idea: @invalid_attrs)

      assert redirected_to(conn) == Routes.home_path(conn, :show)

      conn = get(conn, Routes.home_path(conn, :show))

      refute html_response(conn, 200) =~ "Some Gift Idea"
    end
  end

  describe "delete gift_idea" do
    test "deletes chosen gift_idea", %{conn: conn, user: user} do
      gift_idea = gift_idea_fixture(%{user: user, idea: "Some Gift Idea"})

      conn = delete(conn, Routes.gift_idea_path(conn, :delete, gift_idea))

      assert redirected_to(conn) == Routes.home_path(conn, :show)

      conn = get(conn, Routes.home_path(conn, :show))

      response = html_response(conn, 200)
        assert response =~ "🚮 Gift idea deleted!"
      refute response =~ "Some Gift Idea"
    end
  end
end

defmodule SecretSantaWeb.GiftIdeaControllerTest do
  use SecretSantaWeb.ConnCase

  import SecretSanta.GiftIdeasFixtures

  setup :setup_member_user

  @create_attrs %{idea: "Some Gift Idea"}
  @invalid_attrs %{idea: nil}

  describe "POST /gift_ideas" do
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

      assert get_flash(conn, :error) == "⚠️ Error adding gift idea"
    end
  end

  describe "DELETE /gift_ideas/:id" do
    test "deletes chosen gift_idea", %{conn: conn, user: user} do
      gift_idea = gift_idea_fixture(%{user: user, idea: "Some Gift Idea"})

      conn = delete(conn, Routes.gift_idea_path(conn, :delete, gift_idea))

      assert redirected_to(conn) == Routes.home_path(conn, :show)

      conn = get(conn, Routes.home_path(conn, :show))

      assert get_flash(conn, :info) == "🚮 Gift idea deleted!"
      refute html_response(conn, 200) =~ "Some Gift Idea"
    end
  end
end

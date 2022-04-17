defmodule SecretSantaWeb.GiftIdeaControllerTest do
  use SecretSantaWeb.ConnCase

  import SecretSanta.GiftIdeasFixtures

  @create_attrs %{idea: "some idea"}
  @update_attrs %{idea: "some updated idea"}
  @invalid_attrs %{idea: nil}

  describe "index" do
    test "lists all gift_ideas", %{conn: conn} do
      conn = get(conn, Routes.gift_idea_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Gift ideas"
    end
  end

  describe "new gift_idea" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.gift_idea_path(conn, :new))
      assert html_response(conn, 200) =~ "New Gift idea"
    end
  end

  describe "create gift_idea" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.gift_idea_path(conn, :create), gift_idea: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.gift_idea_path(conn, :show, id)

      conn = get(conn, Routes.gift_idea_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Gift idea"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.gift_idea_path(conn, :create), gift_idea: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Gift idea"
    end
  end

  describe "edit gift_idea" do
    setup [:create_gift_idea]

    test "renders form for editing chosen gift_idea", %{conn: conn, gift_idea: gift_idea} do
      conn = get(conn, Routes.gift_idea_path(conn, :edit, gift_idea))
      assert html_response(conn, 200) =~ "Edit Gift idea"
    end
  end

  describe "update gift_idea" do
    setup [:create_gift_idea]

    test "redirects when data is valid", %{conn: conn, gift_idea: gift_idea} do
      conn = put(conn, Routes.gift_idea_path(conn, :update, gift_idea), gift_idea: @update_attrs)
      assert redirected_to(conn) == Routes.gift_idea_path(conn, :show, gift_idea)

      conn = get(conn, Routes.gift_idea_path(conn, :show, gift_idea))
      assert html_response(conn, 200) =~ "some updated idea"
    end

    test "renders errors when data is invalid", %{conn: conn, gift_idea: gift_idea} do
      conn = put(conn, Routes.gift_idea_path(conn, :update, gift_idea), gift_idea: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Gift idea"
    end
  end

  describe "delete gift_idea" do
    setup [:create_gift_idea]

    test "deletes chosen gift_idea", %{conn: conn, gift_idea: gift_idea} do
      conn = delete(conn, Routes.gift_idea_path(conn, :delete, gift_idea))
      assert redirected_to(conn) == Routes.gift_idea_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.gift_idea_path(conn, :show, gift_idea))
      end
    end
  end

  defp create_gift_idea(_) do
    gift_idea = gift_idea_fixture()
    %{gift_idea: gift_idea}
  end
end

defmodule SecretSantaWeb.GroupControllerTest do
  use SecretSantaWeb.ConnCase

  import SecretSanta.GroupsFixtures

  setup :register_and_log_in_user

  @create_attrs %{name: "Group Name", rules: "Group Rules"}
  @update_attrs %{name: "Updated Group Name", rules: "Updated Group Rules"}
  @invalid_attrs %{name: nil, rules: nil}

  describe "new group" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.group_path(conn, :new))
      assert html_response(conn, 200) =~ "Create a New Group"
    end
  end

  describe "create group" do
    test "redirects to homepage when data is valid", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @create_attrs)

      assert redirected_to(conn) == Routes.home_path(conn, :show)

      conn = get(conn, Routes.home_path(conn, :show))
      assert html_response(conn, 200) =~ "Group Name"
      assert html_response(conn, 200) =~ "Group Rules"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @invalid_attrs)
      assert html_response(conn, 200) =~ "Create a New Group"
    end
  end

  describe "edit group" do
    setup [:create_group]

    test "renders form for editing chosen group", %{conn: conn, group: group} do
      conn = get(conn, Routes.group_path(conn, :edit, group))
      assert html_response(conn, 200) =~ "Edit Group"
    end
  end

  describe "update group" do
    setup %{user: user} do
      group = group_fixture(%{admin: user})
      %{group: group}
    end

    test "redirects when data is valid", %{conn: conn, group: group} do
      conn = put(conn, Routes.group_path(conn, :update, group), group: @update_attrs)

      assert redirected_to(conn) == Routes.home_path(conn, :show)

      conn = get(conn, Routes.home_path(conn, :show))
      assert html_response(conn, 200) =~ "Updated Group Name"
      assert html_response(conn, 200) =~ "Updated Group Rules"
    end

    test "renders errors when data is invalid", %{conn: conn, group: group} do
      conn = put(conn, Routes.group_path(conn, :update, group), group: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Group"
    end
  end

  describe "delete group" do
    setup [:create_group]

    test "deletes chosen group", %{conn: conn, group: group} do
      conn = delete(conn, Routes.group_path(conn, :delete, group))
      assert redirected_to(conn) == Routes.home_path(conn, :show)

      assert_error_sent 404, fn ->
        get(conn, Routes.group_path(conn, :show, group))
      end
    end
  end

  defp create_group(_) do
    group = group_fixture()
    %{group: group}
  end
end

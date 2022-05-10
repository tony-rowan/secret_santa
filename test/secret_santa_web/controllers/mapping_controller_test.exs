defmodule SecretSantaWeb.MappingControllerTest do
  use SecretSantaWeb.ConnCase

  setup :setup_admin_user

  describe "POST /mappings" do
    test "redirects to the homepage after assigning mappings to all members", %{conn: conn} do
      conn = post(conn, Routes.mapping_path(conn, :create))

      assert redirected_to(conn) == Routes.home_path(conn, :show)

      conn = get(conn, Routes.home_path(conn, :show))

      assert get_flash(conn, :info) == "Secret Santa has been started!"
    end
  end
end

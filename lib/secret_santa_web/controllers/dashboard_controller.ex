defmodule SecretSantaWeb.DashboardController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Groups

  def show(conn, _params) do
    user = conn.assigns.current_user
    group = Groups.get_group_for_user(user)

    conn |> assign(:group, group) |> render("show.html")
  end
end

defmodule SecretSantaWeb.DashboardController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Groups
  alias SecretSanta.Repo

  def show(conn, _params) do
    user = conn.assigns.current_user
    group = Groups.get_group_for_user(user) |> Repo.preload(:users)

    conn |> assign(:group, group) |> render("show.html")
  end
end

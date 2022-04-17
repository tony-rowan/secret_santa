defmodule SecretSantaWeb.DashboardController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Groups
  alias SecretSanta.GiftIdeas
  alias SecretSanta.Repo

  def show(conn, _params) do
    user = conn.assigns.current_user
    group = Groups.get_group_for_user(user) |> Repo.preload(:users)
    gift_ideas = GiftIdeas.list_gift_ideas_for_user(user)

    conn
    |> assign(:group, group)
    |> assign(:gift_ideas, gift_ideas)
    |> assign(:gift_idea_changeset, GiftIdeas.empty_changeset())
    |> render("show.html")
  end
end

defmodule SecretSantaWeb.DashboardController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Groups
  alias SecretSanta.GiftIdeas
  alias SecretSanta.Repo

  def show(conn, _params) do
    user = conn.assigns.current_user
    group = Groups.get_group_for_user(user) |> Repo.preload(:users)
    secret_santa = Groups.get_secret_santa_for_user(user.id, group.id)
    is_group_admin = Groups.user_is_group_admin?(user.id, group.id)
    gift_ideas = GiftIdeas.list_gift_ideas_for_user(user)

    conn
    |> assign(:group, group)
    |> assign(:secret_santa, secret_santa)
    |> assign(:is_group_admin, is_group_admin)
    |> assign(:gift_ideas, gift_ideas)
    |> assign(:gift_idea_changeset, GiftIdeas.empty_changeset())
    |> render("show.html")
  end
end

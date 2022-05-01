defmodule SecretSantaWeb.HomeController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Groups
  alias SecretSanta.GiftIdeas

  def show(conn, _params) do
    user = conn.assigns.current_user
    group = Groups.get_group_for_user(user)
    secret_santa = Groups.get_secret_santa_for_user(user, group)
    is_group_admin = Groups.user_is_group_admin?(user, group)
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

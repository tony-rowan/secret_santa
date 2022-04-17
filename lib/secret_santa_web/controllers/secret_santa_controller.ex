defmodule SecretSantaWeb.SecretSantaController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Repo

  alias SecretSanta.Groups

  def start(conn, _params) do
    user = conn.assigns.current_user
    group = Groups.get_group_for_user(user) |> Repo.preload(:secret_santa_pairs)

    Groups.start_secret_santa(group)

    conn
    |> put_flash(:info, "Secret Santa has been started!")
    |> redirect(to: Routes.dashboard_path(conn, :show))
  end
end

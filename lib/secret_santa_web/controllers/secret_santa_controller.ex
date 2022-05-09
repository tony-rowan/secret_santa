defmodule SecretSantaWeb.SecretSantaController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Groups
  alias SecretSanta.Gifting

  def start(conn, _params) do
    user = conn.assigns.current_user
    group = Groups.get_group_for_user(user)

    case Gifting.start_secret_santa(group) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Secret Santa has been started!")
        |> redirect(to: Routes.home_path(conn, :show))

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> redirect(to: Routes.home_path(conn, :show))
    end
  end
end

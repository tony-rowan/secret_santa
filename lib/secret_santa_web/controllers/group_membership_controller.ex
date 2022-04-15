defmodule SecretSantaWeb.GroupMembershipController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Groups
  alias SecretSanta.Groups.JoinRequest

  def new(conn, _params) do
    changeset = Groups.change_join_request(%JoinRequest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"join_request" => join_request_params}) do
    user = conn.assigns.current_user

    case Groups.join_group(user, join_request_params) do
      {:ok, group_membership} ->
        conn
        |> put_flash(:info, "Group joined successfully.")
        |> redirect(to: Routes.dashboard_path(conn, :show))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

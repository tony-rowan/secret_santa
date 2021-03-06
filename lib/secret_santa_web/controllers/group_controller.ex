defmodule SecretSantaWeb.GroupController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Groups
  alias SecretSanta.Groups.Group

  def show(conn, %{"id" => id}) do
    user = conn.assigns.current_user
    group = Groups.get_group!(id) |> Groups.load_group_memberships()
    is_group_admin = Groups.user_is_group_admin?(user, group)

    render(conn, "show.html", group: group, is_group_admin: is_group_admin)
  end

  def new(conn, _params) do
    changeset = Groups.change_group(%Group{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"group" => group_params}) do
    user = conn.assigns.current_user

    case Groups.create_group(user, group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group created successfully.")
        |> redirect(to: Routes.home_path(conn, :show))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    group = Groups.get_group!(id)
    changeset = Groups.change_group(group)
    render(conn, "edit.html", group: group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Groups.get_group!(id)

    case Groups.update_group(group, group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group updated successfully.")
        |> redirect(to: Routes.home_path(conn, :show))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", group: group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Groups.get_group!(id)
    {:ok, _group} = Groups.delete_group(group)

    conn
    |> put_flash(:info, "Group deleted successfully.")
    |> redirect(to: Routes.home_path(conn, :show))
  end
end

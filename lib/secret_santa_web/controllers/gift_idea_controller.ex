defmodule SecretSantaWeb.GiftIdeaController do
  use SecretSantaWeb, :controller

  alias SecretSanta.GiftIdeas

  def create(conn, %{"gift_idea" => gift_idea_params}) do
    user = conn.assigns.current_user

    case GiftIdeas.create_gift_idea(user, gift_idea_params) do
      {:ok, gift_idea} ->
        conn
        |> put_flash(:info, "Gift idea added successfully.")
        |> redirect(to: Routes.dashboard_path(conn, :show))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gift_idea = GiftIdeas.get_gift_idea!(id)
    {:ok, _gift_idea} = GiftIdeas.delete_gift_idea(gift_idea)

    conn
    |> put_flash(:info, "Gift idea deleted successfully.")
    |> redirect(to: Routes.dashboard_path(conn, :index))
  end
end

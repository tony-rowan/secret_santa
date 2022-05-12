defmodule SecretSantaWeb.GiftIdeaController do
  use SecretSantaWeb, :controller

  alias SecretSanta.GiftIdeas

  def create(conn, %{"gift_idea" => gift_idea_params}) do
    user = conn.assigns.current_user

    case GiftIdeas.create_gift_idea(user, gift_idea_params) do
      {:ok, _gift_idea} ->
        conn |> redirect(to: Routes.home_path(conn, :show))

      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_flash(:error, "⚠️ Error adding gift idea")
        |> redirect(to: Routes.home_path(conn, :show))
    end
  end

  def delete(conn, %{"id" => id}) do
    gift_idea = GiftIdeas.get_gift_idea!(id)
    {:ok, _gift_idea} = GiftIdeas.delete_gift_idea(gift_idea)

    conn
    |> put_flash(:info, "🚮 Gift idea deleted!")
    |> redirect(to: Routes.home_path(conn, :show))
  end
end

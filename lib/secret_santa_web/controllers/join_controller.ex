defmodule SecretSantaWeb.JoinController do
  use SecretSantaWeb, :controller

  def show(conn, %{"join_code" => join_code}) do
    conn
    |> redirect(to: Routes.user_registration_path(conn, :new, join_code: join_code))
    |> halt()
  end
end

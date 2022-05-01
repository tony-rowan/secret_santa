defmodule SecretSantaWeb.GetStartedController do
  use SecretSantaWeb, :controller

  def show(conn, _params) do
    render(conn, "show.html")
  end
end

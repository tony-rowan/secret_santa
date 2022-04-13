defmodule SecretSantaWeb.PageController do
  use SecretSantaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

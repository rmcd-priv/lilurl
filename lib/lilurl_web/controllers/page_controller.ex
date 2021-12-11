defmodule LilurlWeb.PageController do
  use LilurlWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

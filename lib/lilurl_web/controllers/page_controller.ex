defmodule LilurlWeb.PageController do
  use LilurlWeb, :controller
  alias Lilurl.Urls.UrlMapping

  def index(conn, _params) do
    changeset = UrlMapping.insert_changeset(%UrlMapping{})
    render(conn, "index.html", changeset: changeset)
  end
end

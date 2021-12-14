defmodule LilurlWeb.UrlMappingController do
  use LilurlWeb, :controller
  alias Lilurl.Urls
  alias Lilurl.Urls.UrlMapping

  def create(conn, params) do
    with {:ok, %{slug: slug}} <- Urls.create_url_mapping(params["url_mapping"]) do
      conn
      |> put_flash(:url, LilurlWeb.Endpoint.url() <> "/" <> slug)
      |> put_view(LilurlWeb.PageView)
      |> render("index.html", changeset: Ecto.Changeset.change(%UrlMapping{}))
    else
      {:error, error} ->
        conn
        |> put_flash(:error, "Oops! We couldn't create your lilurl 😭 Hint: " <> error )
        |> put_view(LilurlWeb.PageView)
        |> render("index.html", changeset: UrlMapping.insert_changeset(%UrlMapping{}, params))
      _ ->
        conn
        |> put_flash(:error, "Oops! We couldn't create your lilurl 😭.")
        |> put_view(LilurlWeb.PageView)
        |> render("index.html", changeset: UrlMapping.insert_changeset(%UrlMapping{}, params))
    end
  end


  def show(conn, params) do
    with %UrlMapping{} = mapping <- Urls.get_url_mapping!(params["slug"]) do
      Urls.update_url_mapping(mapping, %{visits: mapping.visits + 1})
      redirect(conn, external: mapping.url)
    else
      _ ->
        conn
        |> put_status(:not_found)
        |> put_view(LilurlWeb.ErrorView)
        |> render(:"404")
    end
  end
end

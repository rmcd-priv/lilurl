defmodule LilurlWeb.PageControllerTest do
  use LilurlWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Get your lilurl on!"
  end

  test "POST / with valid URL", %{conn: conn} do
    conn = post(conn, "/", url_mapping: %{"url" => "https://google.com"})
    assert html_response(conn, 200) =~ "Your lilurl is: "
  end

  test "POST / with no scheme", %{conn: conn} do
    conn = post(conn, "/", url_mapping: %{"url" => "example.com"})
    assert html_response(conn, 200) =~ "no scheme"
  end

  test "POST / with no host", %{conn: conn} do
    conn = post(conn, "/", url_mapping: %{"url" => "https://"})
    assert html_response(conn, 200) =~ "no host"
  end

  test "POST / with non-existant host", %{conn: conn} do
    conn = post(conn, "/", url_mapping: %{"url" => "https://bob.bob"})
    assert html_response(conn, 200) =~ "could not validate host!"
  end
end

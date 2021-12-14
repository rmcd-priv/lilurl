defmodule Lilurl.UrlsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lilurl.Urls` context.
  """

  @doc """
  Generate a url_mapping.
  """
  def url_mapping_fixture(attrs \\ %{}) do
    {:ok, url_mapping} =
      attrs
      |> Enum.into(%{
        url: "https://example.com"
      })
      |> Lilurl.Urls.create_url_mapping()

    url_mapping
  end
end

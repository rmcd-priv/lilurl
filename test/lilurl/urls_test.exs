defmodule Lilurl.UrlsTest do
  use Lilurl.DataCase

  alias Lilurl.Urls

  describe "url_mappings" do
    alias Lilurl.Urls.UrlMapping

    import Lilurl.UrlsFixtures

    @invalid_attrs %{"url" => ""}

    test "list_url_mappings/0 returns all url_mappings" do
      url_mapping = url_mapping_fixture()
      assert Urls.list_url_mappings() == [url_mapping]
    end

    test "get_url_mapping!/1 returns the url_mapping with given id" do
      url_mapping = url_mapping_fixture()
      assert Urls.get_url_mapping!(url_mapping.id) == url_mapping
    end

    test "create_url_mapping/1 with valid data creates a url_mapping" do
      valid_attrs = %{url: "https://example.com"}

      assert {:ok, %UrlMapping{} = url_mapping} = Urls.create_url_mapping(valid_attrs)
      assert url_mapping.slug == Lilurl.Slug.encode(url_mapping.id)
      assert url_mapping.url == "https://example.com"
      assert url_mapping.visits == 0
    end

    test "create_url_mapping/1 with invalid data returns error tuple" do
      assert {:error, "no scheme (e.g. https://)"} = Urls.create_url_mapping(@invalid_attrs)
    end

    test "update_url_mapping/2 with valid data updates the url_mapping" do
      url_mapping = url_mapping_fixture()
      update_attrs = %{slug: "some updated slug", url: "some updated url", visits: 43}

      assert {:ok, %UrlMapping{} = url_mapping} = Urls.update_url_mapping(url_mapping, update_attrs)
      assert url_mapping.slug == "some updated slug"
      assert url_mapping.url == "some updated url"
      assert url_mapping.visits == 43
    end

    test "update_url_mapping/2 with invalid data returns error changeset" do
      url_mapping = url_mapping_fixture()
      assert {:error, %Ecto.Changeset{}} = Urls.update_url_mapping(url_mapping, @invalid_attrs)
      assert url_mapping == Urls.get_url_mapping!(url_mapping.id)
    end

    test "delete_url_mapping/1 deletes the url_mapping" do
      url_mapping = url_mapping_fixture()
      assert {:ok, %UrlMapping{}} = Urls.delete_url_mapping(url_mapping)
      assert_raise Ecto.NoResultsError, fn -> Urls.get_url_mapping!(url_mapping.id) end
    end

    test "change_url_mapping/1 returns a url_mapping changeset" do
      url_mapping = url_mapping_fixture()
      assert %Ecto.Changeset{} = Urls.change_url_mapping(url_mapping)
    end
  end
end

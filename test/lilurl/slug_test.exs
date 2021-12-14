defmodule Lilurl.SlugTest do
  use Lilurl.DataCase

  alias Lilurl.Slug

  test "it can encode an integer id" do
    assert Slug.encode(500000000000) == "47JG0PbmB"
  end

  test "it can decode a slug into an integer" do
    assert {:ok, [500000000000]} = Slug.decode("47JG0PbmB")
  end
end

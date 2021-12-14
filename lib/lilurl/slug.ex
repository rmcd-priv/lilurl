defmodule Lilurl.Slug do
  @hashids_salt "lilurl"
  @hashids_min_len 8
  @hashid_opts [salt: @hashids_salt, min_len: @hashids_min_len]

  def encode(id) do
    @hashid_opts
    |> Hashids.new()
    |> Hashids.encode(id)
  end

  def decode(slug) do
    @hashid_opts
    |> Hashids.new()
    |> Hashids.decode(slug)
  end
end

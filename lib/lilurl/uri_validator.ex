defmodule URIValidator do
  require Logger
  def validate_uri(binary) do
    uri = URI.parse(binary)
    host = LilurlWeb.Endpoint.host()
    case uri do
      %URI{scheme: nil} -> {:error, "no scheme (e.g. https://)"}
      %URI{host: ^host} -> {:error, "no meta-lilurls! 😂"}
      %URI{host: nil} -> {:error, "no host (e.g. example.com)"}
      %URI{host: ""} -> {:error, "no host (e.g. example.com)"}
      uri -> {:ok, uri}
    end
  end

  def validate_host_exists({:error, _} = error), do: error
  def validate_host_exists({:ok, uri}), do: validate_host_exists(uri)

  def validate_host_exists(%URI{host: host} = uri) do
    case :inet.gethostbyname(to_charlist(host)) do
      {:ok, _} -> {:ok, uri}
      _ -> {:error, "could not validate host!"}
    end
  end
end

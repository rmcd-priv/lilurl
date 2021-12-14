defmodule Lilurl.Urls do
  @moduledoc """
  The Urls context.
  """

  import Ecto.Query, warn: false
  alias Lilurl.Repo

  alias Lilurl.Urls.UrlMapping
  alias Ecto.Multi

  @doc """
  Returns the list of url_mappings.

  ## Examples

      iex> list_url_mappings()
      [%UrlMapping{}, ...]

  """
  def list_url_mappings do
    Repo.all(UrlMapping)
  end

  @doc """
  Gets a single url_mapping.

  Raises `Ecto.NoResultsError` if the Url mapping does not exist.

  ## Examples

      iex> get_url_mapping!(123)
      %UrlMapping{}

      iex> get_url_mapping!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url_mapping!(id) when is_integer(id), do: Repo.get!(UrlMapping, id)

  def get_url_mapping!(slug) when is_binary(slug) do
    case  Lilurl.Slug.decode(slug) do
      {:ok, [id | _]} -> get_url_mapping!(id)
      _ -> {:error, "couldn't parse slug"}
    end
  end

  @doc """
  Creates a url_mapping.

  ## Examples

      iex> create_url_mapping(%{field: value})
      {:ok, %UrlMapping{}}

      iex> create_url_mapping(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url_mapping(_ \\ %{})
  def create_url_mapping(%{url: url}), do: create_url_mapping(%{"url" => url})
  def create_url_mapping(%{"url" => url} = attrs) do
    with {:ok, _} <- URIValidator.validate_uri(url) |> URIValidator.validate_host_exists(),
    {:ok, %{slug_create: url_mapping}} <-
      Multi.new()
      |> Multi.run(:get, fn repo, _changes ->
        {:ok, repo.get_by(UrlMapping, url: url) || %UrlMapping{}}
      end)
      |> Multi.insert_or_update(:url_mapping, fn %{get: url_mapping} ->
            Ecto.Changeset.change(url_mapping, url: url)
          end)
      |> Multi.update(:slug_create, fn %{url_mapping: %{id: url_mapping_id} = inserted_mapping} ->
            inserted_mapping
            |> Ecto.Changeset.change(slug: Lilurl.Slug.encode(url_mapping_id))
            |> UrlMapping.update_changeset()
          end)
      |> Repo.transaction()
    do
      {:ok, url_mapping}
    else
      "" ->
        changeset = UrlMapping.insert_changeset(%UrlMapping{}, attrs)
        {error, _} = changeset.errors[:url]
        {:error, error}

      {:error, error} -> {:error, error}

      foo -> {:error, foo}
    end
  end

  @doc """
  Updates a url_mapping.

  ## Examples

      iex> update_url_mapping(url_mapping, %{field: new_value})
      {:ok, %UrlMapping{}}

      iex> update_url_mapping(url_mapping, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_url_mapping(%UrlMapping{} = url_mapping, attrs) do
    url_mapping
    |> UrlMapping.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a url_mapping.

  ## Examples

      iex> delete_url_mapping(url_mapping)
      {:ok, %UrlMapping{}}

      iex> delete_url_mapping(url_mapping)
      {:error, %Ecto.Changeset{}}

  """
  def delete_url_mapping(%UrlMapping{} = url_mapping) do
    Repo.delete(url_mapping)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url_mapping changes.

  ## Examples

      iex> change_url_mapping(url_mapping)
      %Ecto.Changeset{data: %UrlMapping{}}

  """
  def change_url_mapping(%UrlMapping{} = url_mapping, attrs \\ %{}) do
    UrlMapping.update_changeset(url_mapping, attrs)
  end
end

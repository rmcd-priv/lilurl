defmodule Lilurl.Urls.UrlMapping do
  use Ecto.Schema
  import Ecto.Changeset

  schema "url_mappings" do
    field :slug, :string
    field :url, :string
    field :visits, :integer, default: 0

    timestamps()
  end

  @doc false
  def insert_changeset(url_mapping, attrs \\ %{}) do
    url_mapping
    |> cast(attrs, [:slug, :url, :visits])
    |> validate_required([:url])
  end

    @doc false
    def update_changeset(url_mapping, attrs \\ %{}) do
      url_mapping
      |> cast(attrs, [:slug, :url, :visits])
      |> validate_required([:url])
    end
end

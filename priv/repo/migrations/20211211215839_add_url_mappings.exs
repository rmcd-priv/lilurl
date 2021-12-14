defmodule Lilurl.Repo.Migrations.AddUrlMappings do
  use Ecto.Migration

  def change do
    create table("url_mappings") do
      add :slug,   :string
      add :url,    :string
      add :visits, :integer, default: 0

      timestamps()
    end

    create index("url_mappings", [:slug])
    create unique_index("url_mappings", [:url])
  end
end

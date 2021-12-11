defmodule Lilurl.Repo do
  use Ecto.Repo,
    otp_app: :lilurl,
    adapter: Ecto.Adapters.Postgres
end

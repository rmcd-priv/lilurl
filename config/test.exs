import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :lilurl, Lilurl.Repo,
  username: "postgres",
  password: "postgres",
  database: "lilurl_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  ssl: System.get_env("POSTGRES_SSL") == 'true'

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lilurl, LilurlWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "mKgiErYqHp5Y0mTbPTNhmGM8GkIn8ModoFVfCqBZ+Br3HU7ZHgRTf1mHWkhVQe9x",
  server: false

# In test we don't send emails.
config :lilurl, Lilurl.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

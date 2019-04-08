use Mix.Config

config :bank_api, BankApiWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT") || 4000],
  url: [scheme: "https", host: "intense-scrubland-49795", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  debug_errors: false,
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

config :bank_api,
       BankApi.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "5"),
  ssl: true

config :logger, level: String.to_atom(System.get_env("LOG_LEVEL") || "info")

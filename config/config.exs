import Config

config :api, ecto_repos: [Api.Repo]

config :api, Api.Repo,
  database: "api_repo",
  username: "postgres",
  password: "123",
  hostname: "localhost"

config :api, Api.Guardian,
  issuer: "api",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

config :logger, level: :debug

import Config

config :api, ecto_repos: [Api.Repo]

config :api, Api.Repo,
  database: "api_repo",
  username: "postgres",
  password: "123",
  hostname: "localhost"

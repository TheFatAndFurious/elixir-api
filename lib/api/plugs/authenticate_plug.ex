defmodule Api.AuthenticatePlug do
  import Plug.Conn
  import Api.Guardian
  require Logger

  def init(options), do: options

  def call(conn, _options) do
    Logger.info("shit is working")
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case decode_and_verify(token) do
          {:ok, claims} ->
            conn = assign(conn, :claims, claims)
            conn = assign(conn, :current_user, claims["sub"])
            conn
          {:error, _reason} ->
            conn |> send_resp(401, "Unauthorized") |> halt()
        end
        _->
        conn |> send_resp(401, "Unauthorized") |> halt()
    end
  end
end

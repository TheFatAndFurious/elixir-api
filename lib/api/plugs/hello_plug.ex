defmodule API.Plugs.HelloPlug do
  import Plug.Conn

  def init(options), do: options
  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, 'Hello my g')
  end
end

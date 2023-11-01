defmodule MyAPI.Router do
  use Plug.Router
 plug :match
 plug :dispatch

 get "/" do
   send_resp(conn, 200, "Success")
 end
end

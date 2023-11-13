defmodule MyAPI.Router do
  require Logger
  use Plug.Router

  plug :match
  plug :dispatch
  plug Plug.Logger

  get "/" do
    send_resp(conn, 200, "Welcome to the API")
  end

  # Structures endpoints
  get "/structures" do
    # Here you would normally fetch structures from the database
    json_response = %{message: "List of structures would be here."}
    |> Jason.encode!()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, json_response)
  end

  get "/structures/:id" do
    # Here you would normally fetch a single structure by ID from the database
    json_response = %{message: "Details of structure with ID #{id} would be here."}
    |> Jason.encode!()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, json_response)
  end

  # Coaches endpoints

  get "/coaches" do
    conn = Plug.Conn.fetch_query_params(conn)
    Logger.debug("Query Params: #{inspect(conn.query_params)}")
    id = conn.params["id"]

    if id do
      # Logic to fetch a single coach with the given ID
      json_response = %{message: "Details of coach with ID #{id} would be here."}
      |> Jason.encode!()

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, json_response)
    else
      # Logic to fetch all coaches
      json_response = %{message: "List of coaches would be here."}
      |> Jason.encode!()

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, json_response)
    end
  end

end

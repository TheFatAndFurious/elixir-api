defmodule MyAPI.Router do
  require Logger
  use Plug.Router

  alias Handlers.GenericHandlers

  plug :match
  plug :dispatch
  plug Plug.Logger

   get "/peoples",  do: GenericHandlers.list_resources(conn, Api.Person)

   get "/pictures", do: GenericHandlers.list_resources(conn, Api.Picture)

   get "/roles", do: GenericHandlers.list_resources(conn, Api.Role)

   get "/galleries", do: GenericHandlers.list_resources(conn, Api.Gallery)

   get "/groups", do: GenericHandlers.list_resources(conn, Api.Group)

   get "PictureGalleries", do: GenericHandlers.list.resources(conn, Api.CreatePicturesGalleries)




  # get "/people" do
  #   people = Api.Repo.all(Api.Person)
  #   json_response =
  #     people
  #     |> Enum.map(fn person ->
  #       %{
  #         first_name: person.first_name,
  #       email: person.email
  #       }
  #     end)
  #     |> Jason.encode!()
  #     IO.inspect(conn, label: "after JSON.encode")
  #   conn
  #   |> put_resp_header("Content-Type", "application/json")
  #   IO.inspect(conn, label: "after resp_header")
  #   |> send_resp(200, json_response)
  #   IO.inspect(conn, label: "after response")

  # end

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

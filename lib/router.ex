defmodule MyAPI.Router do
  require Logger
  use Plug.Router

 plug :match
 plug :dispatch
 plug Plug.Logger
#  plug Api.AuthenticatePlug

 get "/" do
   send_resp(conn, 200, "Success")
 end


# FETCH ALL PEOPLE
  get "/people" do
    people = Api.Repo.all(Api.Person)
    json_response =
      people
      |> Enum.map(fn person ->
        %{
          first_name: person.first_name,
        email: person.email
        }
      end)
      |> Jason.encode!()
      IO.inspect(conn, label: "after JSON.encode")
    conn
    |> put_resp_header("Content-Type", "application/json")
    IO.inspect(conn, label: "after resp_header")
    |> send_resp(200, json_response)
    IO.inspect(conn, label: "after response")

  end

  # FETCH PEOPLE BY ID
  get "/people/:id" do
    case Api.Repo.get(Api.Person, id) do
    nil -> send_resp(conn, 404, "Not Found")
    person -> json_data = %{
      first_name: person.first_name,
      email: person.email,
      role_id: person.role_id
    }

    case Jason.encode(json_data) do
      {:ok, json_response} ->
        conn
        |> put_resp_header("Content-Type", "application/json")
        |> send_resp(200, json_response)
      {:error, error_info} ->
        Logger.error("Error: #{error_info}")
        conn
        |> send_resp(500, 'Error encoding data')
    end
  end
end
end

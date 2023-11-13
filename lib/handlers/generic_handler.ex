defmodule Handlers.GenericHandlers do
  alias Hex.Repo
  alias Api.Repo

  # LIST ALL RESOURCES

  def list_resources(conn, resource_module) do
    resources = Api.Repo.all(resource_module)

    if Enum.empty?(resources) do
      send_error_response(conn, 404, "Resource not found")
    else
      mapped_ressources = Enum.map(resources, &resource_module.map_resource/1)
      send_json_response(conn, 200, mapped_ressources)
    end
  end

  # GET A SINGLE RESOURCE BY ID

  def get_resource(conn, %{"id" => id}, resource_module) do
    case Repo.get(resource_module, id) do
      nil->
        send_error_response(conn, 404, "#{Resource_module} not found")
      resource ->
        send_json_response(conn, 200, resource)
    end
  end

  # CREATE A NEW RESOURCE

  def create_resource(conn, params, resource_module) do
    changeset = resource_module.changeset(struct(resource_module, params))

    case Repo.insert(changeset) do
      {:ok, resource} ->
        send_json_response(conn, 201, resource)
      {:error, changeset} ->
        send_error_response(conn, 400, changeset)
    end
  end

  # UPDATE A RESOURCE

  def update_resource(conn, id, params, resource_module) do
    case Repo.get(resource_module, id) do
      nil ->
        send_error_response(conn, 404, "#{Resource_module} not found")
      resource ->
        changeset = resource_module.changeset(resource, params)

        case Repo.update(changeset) do
          {:ok, resource} -> send_json_response(conn, 200, resource)
          {:error, changeset} -> send_error_response(conn, 400, changeset)
        end

    end
  end

  # DELETE A RESOURCE

  def delete_resource(conn, %{"id" => id}, resource_module) do
    case Repo.get(resource_module, id) do
      nil ->
        send_error_response(conn, 404, "#{Resource_module} not found")
      resource ->
        Repo.delete(resource)
        send_json_response(conn, 204, nil)

    end
  end

  # SENDING RESPONSES

  defp send_json_response(conn, status_code, data) do
    json_data = Jason.encode!(data)
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.send_resp(status_code, json_data)
  end

  defp send_error_response(conn, status_code, message) do
    send_json_response(conn, status_code, %{"error" => message})
  end


end

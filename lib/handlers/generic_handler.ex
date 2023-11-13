defmodule MyApi.GenericHandlers do
  alias Hex.Repo
  alias MyApi.Repo

  # LIST ALL RESOURCES

  def list_resoures(conn, _params, resource_module) do
    case Repo.all(resource_module) do
      resources when is_list(resources) ->
        send_json_response(conn, 200, resources)
      _error ->
        send_error_response(conn, 500, "Internal server error")
      end
  end

  # GET A SINGLE RESOURCE BY ID

  def get_resource(conn, %{"id" => id}, resource_module) do
    case Repo.get(resource_module, id) do
      resource ->
        send_json_response(conn, 200, resource)
      nil->
        send_error_response(conn, 404, "#{Resource_module} not found")
    end
  end

  # CREATE A NEW RESOURCE

  def create_resource(conn, params, resource_module) do
    changeset = resource_module.changeset(%{resource_module}, params)

    case Repo.insert(changeset) do
      {:ok, resource} ->
        send_json_response(conn, 201, resource)
      {:error, changeset} ->
        send_error_response(conn, 400, changeset)
    end
  end

  # UPDATE A RESOURCE

  def update_resource(conn, %{"id" => id}, resource_module) do
    case Repo.get(resource_module, id) do
      resource ->
        changeset = resource_module.changeset(resource, params)

        case Repo.update(changeset) do
          {:ok, resource} -> send_json_response(conn, 200, resource)
          {:error, changeset} -> send_error_response(conn, 400, changeset)
        end

      nil ->
        send_error_response(conn, 404, "#{Resource_module} not found")
    end
  end

  # DELETE A RESOURCE

  def delete_resource(conn, %{"id" => id}, resource_module) do
    case Repo.get(resource_module, id) do
      resource ->
        Repo.delete(resource)
        send_json_response(conn, 204, nil)

      nil ->
        send_error_response(conn, 404, "#{Resource_module} not found")
    end
  end

  # SENDING RESPONSES

  defp send_json_response(conn, status_code, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Json.encode!(data))
  end

  defp send_error_response(conn, status_code, message) do
    send_json_response(conn, status_code, %{"error" => message})
  end


end

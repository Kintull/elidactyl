defmodule Elidactyl.Application.Servers do
  @moduledoc false

  alias Elidactyl.Error
  alias Elidactyl.Request
  alias Elidactyl.Response
  alias Elidactyl.Schemas.Server
  alias Elidactyl.Schemas.Server.CreateParams
  alias Elidactyl.Schemas.Server.UpdateDetailsParams

  def list_servers do
    #    GET https://pterodactyl.app/api/application/servers
    with {:ok, resp} <- Request.request(:get, "/api/application/servers"),
         result when is_list(result) <- Response.parse_response(resp) do
      {:ok, result}
    else
      {:error, _} = error ->
        error
    end
  end

  @spec get_server_by_id(binary | integer) :: {:ok, %Server{}} | {:error, Error.t()}
  def get_server_by_id(id) do
    with {:ok, resp} <- Request.request(:get, "/api/application/servers/#{id}"),
         %Server{} = result <- Response.parse_response(resp) do
      {:ok, result}
    else
      {:error, _} = error ->
        error
    end
  end

  @spec get_server_by_external_id(binary | integer) :: {:ok, %Server{}} | {:error, Error.t()}
  def get_server_by_external_id(id) do
    with {:ok, resp} <- Request.request(:get, "/api/application/servers/external/#{id}"),
         %Server{} = result <- Response.parse_response(resp) do
      {:ok, result}
    else
      {:error, _} = error ->
        error
    end
  end

  @spec create_server(map) :: {:ok, %Server{}} | {:error, Error.t()}
  def create_server(params) do
    with %{valid?: true} = changeset <- CreateParams.changeset(%CreateParams{}, params),
         %CreateParams{} = server <- Ecto.Changeset.apply_changes(changeset),
         {:ok, resp} <- Request.request(:post, "/api/application/servers", server),
         %Server{} = result <- Response.parse_response(resp) do
      {:ok, result}
    else
      {:error, _} = error -> error
      %Ecto.Changeset{} = changeset -> {:error, Error.from_changeset(changeset)}
    end
  end

  @spec update_server_details(integer, map) :: {:ok, %Server{}} | {:error, Error.t()}
  def update_server_details(id, params) do
    with %{valid?: true} = changeset <- UpdateDetailsParams.changeset(%UpdateDetailsParams{}, params),
         %UpdateDetailsParams{} = details <- Ecto.Changeset.apply_changes(changeset),
         {:ok, resp} <- Request.request(:patch, "/api/application/servers/#{id}/details", details),
         %Server{} = result <- Response.parse_response(resp) do
      {:ok, result}
    else
      {:error, _} = error -> error
      %Ecto.Changeset{} = changeset -> {:error, Error.from_changeset(changeset)}
    end
  end

  @spec delete_server(binary | integer) :: :ok | {:error, Error.t()}
  def delete_server(id) do
    with {:ok, _resp} <- Request.request(:delete, "/api/application/servers/#{id}") do
      :ok
    else
      {:error, _} = error ->
        error
    end
  end
end
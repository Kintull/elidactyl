defmodule Elidactyl.Schemas.List do
  alias Elidactyl.Response

  @spec parse(map) :: list
  def parse(%{"object" => "list", "data" => data}) do
    Enum.map(data, &Response.parse_response/1)
  end
end
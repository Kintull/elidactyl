defmodule Elidactyl.Error do
  @moduledoc """
  Error struct that contains response from pterodactyl panel.
  """

  @type t :: %__MODULE__{
    type: atom | nil,
    message: String.t | nil,
    details: map,
  }

  defstruct type: nil, message: nil, details: %{}

  @doc """
  Makes error struct from ecto changeset
  """
  @spec from_changeset(Ecto.Changeset.t) :: t
  @spec from_changeset(Ecto.Changeset.t, atom) :: t
  @spec from_changeset(Ecto.Changeset.t, atom, String.t | nil) :: t
  def from_changeset(changeset, type \\ :validation_error, msg \\ nil) do
    details =
      changeset
      |> Ecto.Changeset.traverse_errors(fn {msg, _opts} -> msg end)
      |> Enum.into(%{}, fn {field, messages} -> {field, Enum.join(messages, ", ")} end)

    %__MODULE__{type: type, message: msg, details: details}
  end

  @doc """
  Makes response parsing error
  """
  @spec invalid_response() :: t
  @spec invalid_response(map) :: t
  def invalid_response(details \\ %{}) do
    %__MODULE__{type: :invalid_response, message: "Error while parsing response", details: details}
  end

  @doc """
  Makes Jason encode error
  """
  @spec encode_error(Jason.EncodeError.t | Exception.t) :: t
  @spec encode_error(Jason.EncodeError.t | Exception.t, map) :: t
  def encode_error(error, details \\ %{}) do
    %__MODULE__{type: :json_encode_failed, message: inspect(error), details: details}
  end
end

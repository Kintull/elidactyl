defmodule Elidactyl.Server.Limits do
  @moduledoc false

  use Ecto.Schema
  alias Ecto.Changeset

  @type t :: %__MODULE__{}

  embedded_schema do
    field :memory, :integer
    field :swap, :integer
    field :disk, :integer
    field :io, :integer
    field :cpu, :integer
  end

  @spec changeset(t(), map) :: Changeset.t()
  def changeset(struct, params) do
    struct
    |> Changeset.cast(params, [:memory, :swap, :disk, :io, :cpu])
    |> Changeset.validate_required([:memory, :swap, :disk, :io, :cpu])
    |> Changeset.validate_number(:memory, greater_than_or_equal_to: 0)
    |> Changeset.validate_number(:swap, greater_than_or_equal_to: -1)
    |> Changeset.validate_number(:disk, greater_than_or_equal_to: 0)
    |> Changeset.validate_number(:cpu, greater_than_or_equal_to: 0)
    |> Changeset.validate_inclusion(:io, 10..1000)
  end
end
defmodule Todobackend.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  @required_attrs [:title]
  @optional_attrs [:order, :completed]
  @attrs @required_attrs ++ @optional_attrs

  schema "todos" do
    field :completed, :boolean, default: false
    field :order, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, @attrs)
    |> validate_required(@required_attrs)
  end
end

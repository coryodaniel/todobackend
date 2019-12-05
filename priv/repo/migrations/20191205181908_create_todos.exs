defmodule Todobackend.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :title, :string
      add :order, :integer
      add :completed, :boolean, default: false, null: false

      timestamps()
    end
  end
end

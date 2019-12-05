defmodule TodobackendWeb.TodoView do
  use TodobackendWeb, :view
  alias TodobackendWeb.TodoView
  alias TodobackendWeb.Router.Helpers, as: Routes
  alias TodobackendWeb.Endpoint

  def render("index.json", %{todos: todos}) do
    render_many(todos, TodoView, "todo.json")
  end

  def render("show.json", %{todo: todo}) do
    render_one(todo, TodoView, "todo.json")
  end

  def render("todo.json", %{todo: todo}) do
    %{
      id: todo.id,
      title: todo.title,
      order: todo.order,
      completed: todo.completed,
      url: Routes.todo_url(Endpoint, :show, todo)
    }
  end
end

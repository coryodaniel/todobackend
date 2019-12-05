defmodule TodobackendWeb.TodoControllerTest do
  use TodobackendWeb.ConnCase

  alias Todobackend.Todos
  alias Todobackend.Todos.Todo

  @create_attrs %{
    completed: true,
    order: 42,
    title: "some title"
  }
  @update_attrs %{
    completed: false,
    order: 43,
    title: "some updated title"
  }
  @invalid_attrs %{completed: nil, order: nil, title: nil}

  def fixture(:todo) do
    {:ok, todo} = Todos.create_todo(@create_attrs)
    todo
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all todos", %{conn: conn} do
      conn = get(conn, Routes.todo_path(conn, :index))
      assert json_response(conn, 200) == []
    end
  end

  describe "create todo" do
    test "renders todo when data is valid", %{conn: conn} do
      conn = post(conn, Routes.todo_path(conn, :create), @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.todo_path(conn, :show, id))

      assert %{
               "id" => id,
               "completed" => true,
               "order" => 42,
               "title" => "some title"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.todo_path(conn, :create), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update todo" do
    setup [:create_todo]

    test "renders todo when data is valid", %{conn: conn, todo: %Todo{id: id} = todo} do
      conn = put(conn, Routes.todo_path(conn, :update, todo), @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, Routes.todo_path(conn, :show, id))

      assert %{
               "id" => id,
               "completed" => false,
               "order" => 43,
               "title" => "some updated title"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, todo: todo} do
      conn = put(conn, Routes.todo_path(conn, :update, todo), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete todo" do
    setup [:create_todo]

    test "deletes chosen todo", %{conn: conn, todo: todo} do
      conn = delete(conn, Routes.todo_path(conn, :delete, todo))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.todo_path(conn, :show, todo))
      end
    end
  end

  defp create_todo(_) do
    todo = fixture(:todo)
    {:ok, todo: todo}
  end
end

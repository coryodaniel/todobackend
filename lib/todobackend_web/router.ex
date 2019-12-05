defmodule TodobackendWeb.Router do
  use TodobackendWeb, :router

  def cors(conn, _opts) do
    conn
    |> put_resp_header("access-control-allow-origin", "*")
    |> put_resp_header("access-control-allow-headers", "Content-Type")
    |> put_resp_header("access-control-allow-methods", "GET,PUT,PATCH,OPTIONS,DELETE,POST")
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :cors
    plug :accepts, ["json"]
  end

  scope "/", TodobackendWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", TodobackendWeb do
    pipe_through :api
    resources "/todos", TodoController
    options "/todos", TodoController, :options
    options "/todos/:id", TodoController, :options
    delete "/todos", TodoController, :delete_all
  end
end

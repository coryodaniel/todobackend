defmodule TodobackendWeb.PageController do
  use TodobackendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

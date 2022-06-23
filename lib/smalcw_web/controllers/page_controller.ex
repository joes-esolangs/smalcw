defmodule SmalcwWeb.PageController do
  use SmalcwWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

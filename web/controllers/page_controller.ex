defmodule Spaces.PageController do
  use Spaces.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

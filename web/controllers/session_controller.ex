defmodule Spaces.SessionController do
  use Spaces.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end
end

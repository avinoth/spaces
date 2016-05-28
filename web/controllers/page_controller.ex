defmodule Spaces.PageController do
  use Spaces.Web, :controller
  
  plug Spaces.Plugs.Authentication when action in [:loggedIn]

  def index(conn, _params) do
    render conn, "index.html"
  end

  def loggedIn(conn, _params) do
    render conn, "loggedIn.html"
  end
end

defmodule Spaces.Plugs.Authentication do
  use Spaces.Web, :controller
  import Plug.Conn

  def init(default), do: default

  def call(conn, _params) do
    current_user = get_session(conn, :user)
    if current_user do
      assign(conn, :current_user, current_user)
    else
      conn
        |> put_flash(:error, "You must be logged in to continue")
        |> redirect(to: session_path(conn, :index))
    end
  end
end
defmodule Spaces.UsersController do
  use Spaces.Web, :controller

  require IEx

  plug Spaces.Plugs.Authentication

  def show(conn, params) do
    render conn, "show.html", set_view_variables(conn)
  end

  defp set_view_variables(conn) do
    %{user_name: get_session(conn, :user) |> Map.get(:user_name)}
  end

end
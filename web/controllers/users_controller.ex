defmodule Spaces.UsersController do
  use Spaces.Web, :controller
  alias Spaces.User
  alias Spaces.Post

  require IEx

  plug Spaces.Plugs.Authentication

  def show(conn, params) do
    posts = 
      from(p in Post, where: p.user_id == ^get_user_id(conn))
      |> Repo.all
    render conn, "show.html", set_view_variables(conn, %{posts: posts})
  end

  defp set_view_variables(conn, params_map) do
    Map.put(params_map, :user_name, get_session(conn, :user) |> Map.get(:user_name))
  end

  defp get_user_id(conn) do
    get_session(conn, :user) |> Map.get(:user_id)
  end

end
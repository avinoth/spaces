defmodule Spaces.PageView do
  use Spaces.Web, :view

  def signed_in?(conn) do
    Plug.Conn.get_session(conn, :user) |> is_nil
  end
end

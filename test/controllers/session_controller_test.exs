defmodule Spaces.SesssionControllerTest do
  use Spaces.ConnCase

  test "/index works proprely", %{conn: conn} do
    conn = get conn, "/session"
    assert html_response(conn, 200) =~ "Welcome to Sign In Procedure"
  end
end

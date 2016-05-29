defmodule Spaces.PageControllerTest do
  use Spaces.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Sharing snippets on the go"
  end
end

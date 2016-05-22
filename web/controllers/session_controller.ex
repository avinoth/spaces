defmodule Spaces.SessionController do
  use Spaces.Web, :controller
  require IEx

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, %{"code" => code}) do
    IEx.pry
    render conn, "new.html"
  end

  def slackLogin(conn, _params) do
    url_params = %{client_id: "35296394051.35346594944", scope: "identify", redirect_uri: session_url(conn, :new)}
    redirect_url = %URI{path: "https://slack.com/oauth/authorize", query: URI.encode_query(url_params)}
    |> URI.to_string
    redirect conn, external: redirect_url 
  end
end

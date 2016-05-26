defmodule Spaces.SessionController do
  use Spaces.Web, :controller
  require IEx

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, %{"code" => code}) do
    url_params = %{client_id: "35296394051.35346594944", client_secret: "b19768c064c2825465b668bf74e7b46b", redirect_uri: session_url(conn, :new)}
      get_url = %URI{path: "https://slack.com/api/oauth.access", query: URI.encode_query(url_params)}
    |> URI.to_string
    case HTTPoison.get(get_url) do
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        repsonse="ok"
        body = :jsx.decode(body)
        case body do
          [_,{"error",_}] ->
            conn = put_flash(conn, :error, "Error in repsone that was received from slack")
          _ ->
            [_,{_,access_token},_,{_,user_id},{_,team_name},{_,team_id}] = body
            conn = put_session(conn, :user, [team_name: team_name, team_id: team_id, user_id: user_id])
        end
      {:error, %HTTPoison.Error{reason: reason}} ->
          conn = put_flash(conn, :error, "Bad Request sent to slack")
    end
    render conn, "new.html"
  end

  def slackLogin(conn, _params) do
    url_params = %{client_id: "35296394051.35346594944", scope: "identify", redirect_uri: session_url(conn, :new)}
    redirect_url = %URI{path: "https://slack.com/oauth/authorize", query: URI.encode_query(url_params)}
    |> URI.to_string
    redirect conn, external: redirect_url 
  end
end

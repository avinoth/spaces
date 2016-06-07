defmodule Spaces.SessionController do
  use Spaces.Web, :controller
  alias Spaces.User

  require IEx

  def index(conn, _params) do
    render conn, "index.html"
  end

  def slackLogin(conn, _params) do
    url_params = %{client_id: "35296394051.35346594944", scope: "users:read", redirect_uri: session_url(conn, :new)}
    redirect_url = 
      %URI{path: "https://slack.com/oauth/authorize", query: URI.encode_query(url_params)}
      |> URI.to_string
    redirect conn, external: redirect_url 
  end  

  def new(conn, %{"code" => code}) do
    url_params = %{client_id: System.get_env("SLACK_CLIENT_ID"), client_secret: System.get_env("SLACK_CLIENT_SECRET"), redirect_uri: session_url(conn, :new), code: code}
    get_url = 
      %URI{path: "https://slack.com/api/oauth.access", query: URI.encode_query(url_params)}
      |> URI.to_string
    
    case HTTPoison.get(get_url) do
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        repsonse="ok"
        body = :jsx.decode(body)
        case body do
          [_,{"error",_}] ->
            conn = put_flash(conn, :error, "Error in repsone that was received from slack")
          _ ->
            conn = set_user_from_response(conn, body)
        end
      {:error, %HTTPoison.Error{reason: reason}} ->
          conn = put_flash(conn, :error, "Bad Request sent to slack")
    end
    redirect(conn, to: page_path(conn, :index))
  end

  def destroy(conn, _params) do
    conn
    |> clear_session
    |> redirect(to: page_path(conn, :index))
  end

  defp set_user_from_response(conn, body) do
    [_,{_,access_token},_,{_,user_id},{_,team_name},{_,team_id}] = body
    url_params = %{token: access_token, user: user_id}
    get_url = %URI{path: "https://slack.com/api/users.info", query: URI.encode_query(url_params)}
    case HTTPoison.get(get_url) do
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
       %{"user" => %{"id" => slack_id , "name" => name, "profile" => %{"real_name" => real_name}}} = Poison.decode!(body)
       if team_id == System.get_env("REAL_IMAGE_TEAM_ID") do 
        if Repo.get_by(User, slack_id: slack_id) |> is_nil do
         changeset = User.changeset(%User{}, %{name: real_name, slack_name: name, slack_id: slack_id})
         case Repo.insert(changeset) do
           {:ok, _user} ->
             put_flash(conn, :info, "User created successfully.")
           {:error, changeset} ->
             conn = put_flash(conn, :error, "Error when creating User, check with Admin #{changeset.errors}")
            end
        else
          conn = put_flash(conn, :info, "Welcome Back")
        end
        put_session(conn, :user, [team_name: team_name, team_id: team_id, user_id: user_id])
       else
         put_flash(conn, :error, "Apologies, we currently allow on Real Image Team Memebers")
       end
      {:error, %HTTPoison.Error{reason: reason}} ->
        put_flash(conn, :error, "Error in repsone when using API call to get user info from token- #{reason}")
    end  
  end


end

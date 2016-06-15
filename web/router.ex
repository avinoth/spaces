defmodule Spaces.Router do
  use Spaces.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Spaces do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/loggedIn", PageController, :loggedIn

    resources "/session", SessionController, only: [:index, :new]
    post "/session/slackLogin", SessionController, :slackLogin
    delete "/session/destroy", SessionController, :destroy

    get "/user", UsersController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", Spaces do
  #   pipe_through :api
  # end
end

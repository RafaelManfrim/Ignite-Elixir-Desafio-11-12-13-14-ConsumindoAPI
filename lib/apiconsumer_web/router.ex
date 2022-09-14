defmodule ApiconsumerWeb.Router do
  use ApiconsumerWeb, :router
  alias ApiconsumerWeb.Plugs.UUIDChecker

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  pipeline :auth do
    plug ApiconsumerWeb.Auth.Pipeline
  end

  scope "/api", ApiconsumerWeb do
    pipe_through [:api, :auth]

    get "/fetch_github/:username", GitHubController, :fetch
  end

  scope "/api", ApiconsumerWeb do
    pipe_through :api

    post "users", UsersController, :create
    post "/users/login", UsersController, :sign_in
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ApiconsumerWeb.Telemetry
    end
  end
end

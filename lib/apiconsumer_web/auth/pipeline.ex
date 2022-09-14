defmodule ApiconsumerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :apiconsumer

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end

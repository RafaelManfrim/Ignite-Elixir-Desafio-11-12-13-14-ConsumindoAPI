defmodule ApiconsumerWeb.UsersController do
  use ApiconsumerWeb, :controller
  alias Apiconsumer.User
  alias ApiconsumerWeb.Auth.Guardian
  alias ApiconsumerWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Apiconsumer.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn |> put_status(:created) |> render("create.json", user: user, token: token)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn |> put_status(:ok) |> render("sign_in.json", token: token)
    end
  end
end

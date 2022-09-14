
defmodule ApiconsumerWeb.GitHubController do
  use ApiconsumerWeb, :controller
  alias ApiconsumerWeb.FallbackController

  action_fallback FallbackController

  def fetch(conn, %{"username" => username}) do
    with {:ok, repositories_list} <- Apiconsumer.fetch_user_repositories(username) do
      conn |> put_status(:ok) |> render("list.json", repositories_list: repositories_list)
    end
  end
end

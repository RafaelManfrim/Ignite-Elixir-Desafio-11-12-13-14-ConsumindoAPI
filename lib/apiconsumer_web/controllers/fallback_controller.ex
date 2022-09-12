defmodule ApiconsumerWeb.FallbackController do
  use ApiconsumerWeb, :controller
  alias Apiconsumer.Error
  alias ApiconsumerWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn |> put_status(status) |> put_view(ErrorView) |> render("error.json", result: result)
  end
end

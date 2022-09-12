defmodule Apiconsumer.GitHub.ListRepositories do
  use Tesla
  alias Apiconsumer.Error
  alias Tesla.Env

  @base_url "https://api.github.com/users/"
  plug Tesla.Middleware.JSON

  def call(params) do
    with {:ok, %Env{status: 200, body: body}} <- Tesla.get("#{@base_url}#{params}/repos", headers: [{"user-agent", "Tesla-Apiconsumer-Ignite"}]) do
      {:ok, body}
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end
end

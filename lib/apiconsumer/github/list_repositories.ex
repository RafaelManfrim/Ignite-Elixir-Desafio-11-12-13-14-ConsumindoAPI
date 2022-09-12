defmodule Apiconsumer.Github.ListRepositories do
  use Tesla
  alias Apiconsumer.Error
  alias Tesla.Env

  @base_url "https://api.github.com/users/"

  def call(url \\ @base_url, params) do
    with {:ok, %Env{status: 200, body: body}} <- Tesla.get("#{url}#{params}/repos", headers: [{"user-agent", "Tesla-Apiconsumer-Ignite"}]) do
      {:ok, body}
    else
      {:ok, %Env{status: 404}} -> {:error, Error.build(:not_found, message: "Not found")}
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end
end

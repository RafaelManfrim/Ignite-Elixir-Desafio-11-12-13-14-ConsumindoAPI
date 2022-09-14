defmodule Apiconsumer do
  alias Apiconsumer.Github.ListRepositories
  alias Apiconsumer.Users.Create, as: CreateUser

  defdelegate fetch_user_repositories(params), to: ListRepositories, as: :call
  defdelegate create_user(params), to: CreateUser, as: :call
end

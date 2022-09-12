defmodule Apiconsumer do
  alias Apiconsumer.Github.ListRepositories

  defdelegate fetch_user_repositories(params), to: ListRepositories, as: :call
end

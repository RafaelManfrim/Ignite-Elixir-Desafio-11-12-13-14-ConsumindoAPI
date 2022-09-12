defmodule Apiconsumer do
  alias Apiconsumer.GitHub.ListRepositories

  defdelegate fetch_user_repositories(params), to: ListRepositories, as: :call
end

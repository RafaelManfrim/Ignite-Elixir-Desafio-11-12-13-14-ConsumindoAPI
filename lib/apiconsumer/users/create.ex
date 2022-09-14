defmodule Apiconsumer.Users.Create do
  alias Apiconsumer.{Error, Repo, User}

  def call(params) do
    params |> User.changeset() |> Repo.insert() |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end

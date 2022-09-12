defmodule ApiconsumerWeb.GitHubView do
  use ApiconsumerWeb, :view

  def render("list.json", %{repositories_list: repositories_list}) do
    Enum.map(Jason.decode!(repositories_list), fn repository -> format_repository(repository) end)
  end

  defp format_repository(%{"id" => id, "name" => name, "description" => description, "html_url" => html_url, "stargazers_count" => stargazers_count}) do
    %{id: id, name: name, description: description, html_url: html_url, stargazers_count: stargazers_count}
  end
end

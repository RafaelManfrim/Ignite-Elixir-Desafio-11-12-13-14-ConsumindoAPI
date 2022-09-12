defmodule Apiconsumer.Github.ListRepositoriesTest do
  use ExUnit.Case, async: true
  alias Apiconsumer.Github.ListRepositories
  alias Plug.Conn

  describe "call/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid username, returns the user repositories", %{bypass: bypass} do
      username = "rafaelmanfrim"

      url = endpoint_url(bypass.port)

      body = ~s([{"description":null,"html_url":"https://github.com/RafaelManfrim/02-ignite-timer","id":512059960,"name":"02-ignite-timer","stargazers_count":1},{"description":null,"html_url":"https://github.com/RafaelManfrim/03-dtmoney2.0","id":522743816,"name":"03-dtmoney2.0","stargazers_count":1},{"description":null,"html_url":"https://github.com/RafaelManfrim/04-ignite-shop","id":533971043,"name":"04-ignite-shop","stargazers_count":1},{"description":"Software que recebe um CEP e por meio da API ViaCEP recebe as informações em formato JSON, exibindo então para o usuário.","html_url":"https://github.com/RafaelManfrim/app_pesquisa_endereco","id":377612241,"name":"app_pesquisa_endereco","stargazers_count":1},{"description":null,"html_url":"https://github.com/RafaelManfrim/certificate-ignite","id":526434488,"name":"certificate-ignite","stargazers_count":1}])

      Bypass.expect(bypass, "GET", "#{username}/repos/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = ListRepositories.call(url, username)

      expected_response = {:ok, "[{\"description\":null,\"html_url\":\"https://github.com/RafaelManfrim/02-ignite-timer\",\"id\":512059960,\"name\":\"02-ignite-timer\",\"stargazers_count\":1},{\"description\":null,\"html_url\":\"https://github.com/RafaelManfrim/03-dtmoney2.0\",\"id\":522743816,\"name\":\"03-dtmoney2.0\",\"stargazers_count\":1},{\"description\":null,\"html_url\":\"https://github.com/RafaelManfrim/04-ignite-shop\",\"id\":533971043,\"name\":\"04-ignite-shop\",\"stargazers_count\":1},{\"description\":\"Software que recebe um CEP e por meio da API ViaCEP recebe as informações em formato JSON, exibindo então para o usuário.\",\"html_url\":\"https://github.com/RafaelManfrim/app_pesquisa_endereco\",\"id\":377612241,\"name\":\"app_pesquisa_endereco\",\"stargazers_count\":1},{\"description\":null,\"html_url\":\"https://github.com/RafaelManfrim/certificate-ignite\",\"id\":526434488,\"name\":\"certificate-ignite\",\"stargazers_count\":1}]"}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end

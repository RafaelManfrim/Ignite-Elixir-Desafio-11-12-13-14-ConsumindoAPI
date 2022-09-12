defmodule Apiconsumer.Repo do
  use Ecto.Repo,
    otp_app: :apiconsumer,
    adapter: Ecto.Adapters.Postgres
end

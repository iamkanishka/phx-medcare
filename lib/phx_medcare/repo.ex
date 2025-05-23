defmodule PhxMedcare.Repo do
  use Ecto.Repo,
    otp_app: :phx_medcare,
    adapter: Ecto.Adapters.Postgres
end

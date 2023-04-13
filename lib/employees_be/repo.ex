defmodule EmployeesApi.Repo do
  use Ecto.Repo,
    otp_app: :employees_api,
    adapter: Ecto.Adapters.Postgres
end

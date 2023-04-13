defmodule EmployeesApi.ManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EmployeesApi.Management` context.
  """

  @doc """
  Generate a employee.
  """
  def employee_fixture(attrs \\ %{}) do
    {:ok, employee} =
      attrs
      |> Enum.into(%{
        dob: ~D[2023-04-12],
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        permanent: true,
        picture_id: "some picture_id"
      })
      |> EmployeesApi.Management.create_employee()

    employee
  end
end

defmodule EmployeesApi.ManagementTest do
  use EmployeesApi.DataCase

  alias EmployeesApi.Management

  describe "employees" do
    alias EmployeesApi.Management.Employee

    import EmployeesApi.ManagementFixtures

    @invalid_attrs %{
      dob: nil,
      email: nil,
      first_name: nil,
      last_name: nil,
      permanent: nil,
      picture_id: nil
    }

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Management.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Management.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      valid_attrs = %{
        dob: ~D[2023-04-12],
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        permanent: true,
        picture_id: "some picture_id"
      }

      assert {:ok, %Employee{} = employee} = Management.create_employee(valid_attrs)
      assert employee.dob == ~D[2023-04-12]
      assert employee.email == "some email"
      assert employee.first_name == "some first_name"
      assert employee.last_name == "some last_name"
      assert employee.permanent == true
      assert employee.picture_id == "some picture_id"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Management.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()

      update_attrs = %{
        dob: ~D[2023-04-13],
        email: "some updated email",
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        permanent: false,
        picture_id: "some updated picture_id"
      }

      assert {:ok, %Employee{} = employee} = Management.update_employee(employee, update_attrs)
      assert employee.dob == ~D[2023-04-13]
      assert employee.email == "some updated email"
      assert employee.first_name == "some updated first_name"
      assert employee.last_name == "some updated last_name"
      assert employee.permanent == false
      assert employee.picture_id == "some updated picture_id"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Management.update_employee(employee, @invalid_attrs)
      assert employee == Management.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Management.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Management.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Management.change_employee(employee)
    end
  end
end

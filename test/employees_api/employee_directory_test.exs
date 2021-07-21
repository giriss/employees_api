defmodule EmployeesApi.EmployeeDirectoryTest do
  use EmployeesApi.DataCase

  alias EmployeesApi.EmployeeDirectory

  describe "job_titles" do
    alias EmployeesApi.EmployeeDirectory.JobTitle

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def job_title_fixture(attrs \\ %{}) do
      {:ok, job_title} =
        attrs
        |> Enum.into(@valid_attrs)
        |> EmployeeDirectory.create_job_title()

      job_title
    end

    test "list_job_titles/0 returns all job_titles" do
      job_title = job_title_fixture()
      assert EmployeeDirectory.list_job_titles() == [job_title]
    end

    test "get_job_title!/1 returns the job_title with given id" do
      job_title = job_title_fixture()
      assert EmployeeDirectory.get_job_title!(job_title.id) == job_title
    end

    test "create_job_title/1 with valid data creates a job_title" do
      assert {:ok, %JobTitle{} = job_title} = EmployeeDirectory.create_job_title(@valid_attrs)
      assert job_title.description == "some description"
      assert job_title.name == "some name"
    end

    test "create_job_title/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EmployeeDirectory.create_job_title(@invalid_attrs)
    end

    test "update_job_title/2 with valid data updates the job_title" do
      job_title = job_title_fixture()
      assert {:ok, %JobTitle{} = job_title} = EmployeeDirectory.update_job_title(job_title, @update_attrs)
      assert job_title.description == "some updated description"
      assert job_title.name == "some updated name"
    end

    test "update_job_title/2 with invalid data returns error changeset" do
      job_title = job_title_fixture()
      assert {:error, %Ecto.Changeset{}} = EmployeeDirectory.update_job_title(job_title, @invalid_attrs)
      assert job_title == EmployeeDirectory.get_job_title!(job_title.id)
    end

    test "delete_job_title/1 deletes the job_title" do
      job_title = job_title_fixture()
      assert {:ok, %JobTitle{}} = EmployeeDirectory.delete_job_title(job_title)
      assert_raise Ecto.NoResultsError, fn -> EmployeeDirectory.get_job_title!(job_title.id) end
    end

    test "change_job_title/1 returns a job_title changeset" do
      job_title = job_title_fixture()
      assert %Ecto.Changeset{} = EmployeeDirectory.change_job_title(job_title)
    end
  end

  describe "employees" do
    alias EmployeesApi.EmployeeDirectory.Employee

    @valid_attrs %{dob: ~D[2010-04-17], email: "some email", first_name: "some first_name", last_name: "some last_name", permanent: true, status: 42}
    @update_attrs %{dob: ~D[2011-05-18], email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", permanent: false, status: 43}
    @invalid_attrs %{dob: nil, email: nil, first_name: nil, last_name: nil, permanent: nil, status: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> EmployeeDirectory.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert EmployeeDirectory.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert EmployeeDirectory.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = EmployeeDirectory.create_employee(@valid_attrs)
      assert employee.dob == ~D[2010-04-17]
      assert employee.email == "some email"
      assert employee.first_name == "some first_name"
      assert employee.last_name == "some last_name"
      assert employee.permanent == true
      assert employee.status == 42
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EmployeeDirectory.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = EmployeeDirectory.update_employee(employee, @update_attrs)
      assert employee.dob == ~D[2011-05-18]
      assert employee.email == "some updated email"
      assert employee.first_name == "some updated first_name"
      assert employee.last_name == "some updated last_name"
      assert employee.permanent == false
      assert employee.status == 43
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = EmployeeDirectory.update_employee(employee, @invalid_attrs)
      assert employee == EmployeeDirectory.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = EmployeeDirectory.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> EmployeeDirectory.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = EmployeeDirectory.change_employee(employee)
    end
  end
end

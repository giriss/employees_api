defmodule EmployeesApiWeb.EmployeeControllerTest do
  use EmployeesApiWeb.ConnCase

  import EmployeesApi.ManagementFixtures

  alias EmployeesApi.Management.Employee

  @create_attrs %{
    dob: ~D[2023-04-12],
    email: "some email",
    first_name: "some first_name",
    last_name: "some last_name",
    permanent: true,
    picture_id: "some picture_id"
  }
  @update_attrs %{
    dob: ~D[2023-04-13],
    email: "some updated email",
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    permanent: false,
    picture_id: "some updated picture_id"
  }
  @invalid_attrs %{
    dob: nil,
    email: nil,
    first_name: nil,
    last_name: nil,
    permanent: nil,
    picture_id: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all employees", %{conn: conn} do
      conn = get(conn, ~p"/api/employees")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create employee" do
    test "renders employee when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/employees", employee: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/employees/#{id}")

      assert %{
               "id" => ^id,
               "dob" => "2023-04-12",
               "email" => "some email",
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "permanent" => true,
               "picture_id" => "some picture_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/employees", employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update employee" do
    setup [:create_employee]

    test "renders employee when data is valid", %{
      conn: conn,
      employee: %Employee{id: id} = employee
    } do
      conn = put(conn, ~p"/api/employees/#{employee}", employee: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/employees/#{id}")

      assert %{
               "id" => ^id,
               "dob" => "2023-04-13",
               "email" => "some updated email",
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "permanent" => false,
               "picture_id" => "some updated picture_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, employee: employee} do
      conn = put(conn, ~p"/api/employees/#{employee}", employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete employee" do
    setup [:create_employee]

    test "deletes chosen employee", %{conn: conn, employee: employee} do
      conn = delete(conn, ~p"/api/employees/#{employee}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/employees/#{employee}")
      end
    end
  end

  defp create_employee(_) do
    employee = employee_fixture()
    %{employee: employee}
  end
end

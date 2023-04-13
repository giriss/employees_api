defmodule EmployeesApiWeb.EmployeeController do
  use EmployeesApiWeb, :controller

  alias EmployeesApi.Management
  alias EmployeesApi.Management.Employee
  alias EmployeesApi.Cloudinary

  plug EmployeesApiWeb.Authenticate

  action_fallback EmployeesApiWeb.FallbackController

  def index(conn, _params) do
    employees = Management.list_employees()
    render(conn, :index, employees: employees)
  end

  def create(conn, %{"employee" => employee_params}) do
    with {:ok, %Employee{} = employee} <- Management.create_employee(employee_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/employees/#{employee}")
      |> render(:show, employee: employee)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = Management.get_employee!(id)
    render(conn, :show, employee: employee)
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Management.get_employee!(id)

    with {:ok, %Employee{} = employee} <- Management.update_employee(employee, employee_params) do
      render(conn, :show, employee: employee)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Management.get_employee!(id)

    with {:ok, %Employee{}} <- Management.delete_employee(employee) do
      send_resp(conn, :no_content, "")
    end
  end

  def upload_picture(conn, %{"employee_id" => id, "picture" => picture}) do
    employee = Management.get_employee!(id)

    if employee.picture_id !== nil, do: Cloudinary.destroy(employee.picture_id)

    picture_id =
      picture
      |> Cloudinary.upload()
      |> Map.fetch!("public_id")

    with {:ok, %Employee{} = employee} <-
           Management.update_employee(employee, %{picture_id: picture_id}) do
      render(conn, "show.json", employee: employee)
    end
  end

  def delete_picture(conn, %{"employee_id" => id}) do
    employee = Management.get_employee!(id)

    if employee.picture_id !== nil, do: Cloudinary.destroy(employee.picture_id)

    with {:ok, %Employee{} = employee} <-
           Management.update_employee(employee, %{picture_id: nil}) do
      render(conn, "show.json", employee: employee)
    end
  end
end

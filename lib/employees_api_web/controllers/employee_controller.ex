defmodule EmployeesApiWeb.EmployeeController do
  use EmployeesApiWeb, :controller

  alias EmployeesApi.EmployeeDirectory
  alias EmployeesApi.Cloudinary
  alias EmployeesApi.EmployeeDirectory.Employee

  plug EmployeesApiWeb.Authenticate

  action_fallback EmployeesApiWeb.FallbackController

  def index(conn, _params) do
    employees = EmployeeDirectory.list_employees()
    render(conn, "index.json", employees: employees)
  end

  def create(conn, %{"employee" => employee_params}) do
    with {:ok, %Employee{} = employee} <- EmployeeDirectory.create_employee(employee_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.employee_path(conn, :show, employee))
      |> render("show.json", employee: employee)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = EmployeeDirectory.get_employee!(id)
    render(conn, "show.json", employee: employee)
  end

  def upload_picture(conn, %{"id" => id, "picture" => picture}) do
    employee = EmployeeDirectory.get_employee!(id)

    if employee.picture_id !== nil, do: Cloudinary.destroy(employee.picture_id)

    picture_id = Cloudinary.upload(picture) |> Map.fetch!("public_id")

    with {:ok, %Employee{} = employee} <-
           EmployeeDirectory.update_employee(employee, %{picture_id: picture_id}) do
      render(conn, "show.json", employee: employee)
    end
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = EmployeeDirectory.get_employee!(id)

    with {:ok, %Employee{} = employee} <-
           EmployeeDirectory.update_employee(employee, employee_params) do
      render(conn, "show.json", employee: employee)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = EmployeeDirectory.get_employee!(id)

    if employee.picture_id !== nil, do: Cloudinary.destroy(employee.picture_id)

    with {:ok, %Employee{}} <- EmployeeDirectory.delete_employee(employee) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule EmployeesApiWeb.JobTitleController do
  use EmployeesApiWeb, :controller

  alias EmployeesApi.EmployeeDirectory
  alias EmployeesApi.EmployeeDirectory.JobTitle

  plug EmployeesApi.Authenticate

  action_fallback EmployeesApiWeb.FallbackController

  def index(conn, _params) do
    job_titles = EmployeeDirectory.list_job_titles()
    render(conn, "index.json", job_titles: job_titles)
  end

  def create(conn, %{"job_title" => job_title_params}) do
    with {:ok, %JobTitle{} = job_title} <- EmployeeDirectory.create_job_title(job_title_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.job_title_path(conn, :show, job_title))
      |> render("show.json", job_title: job_title)
    end
  end

  def show(conn, %{"id" => id}) do
    job_title = EmployeeDirectory.get_job_title!(id)
    render(conn, "show.json", job_title: job_title)
  end

  def update(conn, %{"id" => id, "job_title" => job_title_params}) do
    job_title = EmployeeDirectory.get_job_title!(id)

    with {:ok, %JobTitle{} = job_title} <- EmployeeDirectory.update_job_title(job_title, job_title_params) do
      render(conn, "show.json", job_title: job_title)
    end
  end

  def delete(conn, %{"id" => id}) do
    job_title = EmployeeDirectory.get_job_title!(id)

    with {:ok, %JobTitle{}} <- EmployeeDirectory.delete_job_title(job_title) do
      send_resp(conn, :no_content, "")
    end
  end
end

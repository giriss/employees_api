defmodule EmployeesApiWeb.JobTitleControllerTest do
  use EmployeesApiWeb.ConnCase

  alias EmployeesApi.EmployeeDirectory
  alias EmployeesApi.EmployeeDirectory.JobTitle

  @create_attrs %{
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:job_title) do
    {:ok, job_title} = EmployeeDirectory.create_job_title(@create_attrs)
    job_title
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all job_titles", %{conn: conn} do
      conn = get(conn, Routes.job_title_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create job_title" do
    test "renders job_title when data is valid", %{conn: conn} do
      conn = post(conn, Routes.job_title_path(conn, :create), job_title: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.job_title_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.job_title_path(conn, :create), job_title: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update job_title" do
    setup [:create_job_title]

    test "renders job_title when data is valid", %{
      conn: conn,
      job_title: %JobTitle{id: id} = job_title
    } do
      conn = put(conn, Routes.job_title_path(conn, :update, job_title), job_title: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.job_title_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, job_title: job_title} do
      conn = put(conn, Routes.job_title_path(conn, :update, job_title), job_title: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete job_title" do
    setup [:create_job_title]

    test "deletes chosen job_title", %{conn: conn, job_title: job_title} do
      conn = delete(conn, Routes.job_title_path(conn, :delete, job_title))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.job_title_path(conn, :show, job_title))
      end
    end
  end

  defp create_job_title(_) do
    job_title = fixture(:job_title)
    %{job_title: job_title}
  end
end

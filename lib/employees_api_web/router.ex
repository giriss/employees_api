defmodule EmployeesApiWeb.Router do
  use EmployeesApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", EmployeesApiWeb do
    pipe_through :api

    resources "/job_titles", JobTitleController, except: [:new, :edit]

    resources "/employees", EmployeeController, except: [:new, :edit]
    scope "/employees" do
      put "/:id/picture", EmployeeController, :upload_picture
      delete "/:id/picture", EmployeeController, :delete_picture
    end

    resources "/users", UserController, only: [:create]
    scope "/users" do
      post "/login", UserController, :login
    end
  end
end

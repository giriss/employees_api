defmodule EmployeesApiWeb.Router do
  use EmployeesApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", EmployeesApiWeb do
    pipe_through :api

    resources "/job_titles", JobTitleController, except: [:new, :edit]
    resources "/employees", EmployeeController, except: [:new, :edit]

    resources "/users", UserController, only: [:create]
    post "/users/login", UserController, :login
  end
end

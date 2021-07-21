defmodule EmployeesApiWeb.Router do
  use EmployeesApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EmployeesApiWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create]
    post "/users/login", UserController, :login

    resources "/job_titles", JobTitleController, except: [:new, :edit]

    resources "/employees", EmployeeController, except: [:new, :edit]
  end
end

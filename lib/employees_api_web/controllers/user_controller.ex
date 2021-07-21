defmodule EmployeesApiWeb.UserController do
  use EmployeesApiWeb, :controller

  alias EmployeesApi.Accounts
  alias EmployeesApi.Accounts.User

  action_fallback EmployeesApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

	def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
		user = Accounts.get_user!(username)
		render(conn, "access_token.json", user: user)
	end
end

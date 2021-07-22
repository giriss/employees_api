defmodule EmployeesApiWeb.UserController do
  use EmployeesApiWeb, :controller

  alias EmployeesApi.Accounts
  alias EmployeesApi.Accounts.User

  import Bcrypt, only: [check_pass: 2]

  action_fallback EmployeesApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    user = Accounts.get_user!(username)

    case check_pass(user, password) do
      {:ok, _} ->
        render(conn, "access_token.json", user: user)

      {:error, _} ->
        conn
        |> put_status(:unauthorized)
        |> render("unauthorized.json")
    end
  end
end

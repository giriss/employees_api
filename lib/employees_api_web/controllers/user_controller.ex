defmodule EmployeesApiWeb.UserController do
  use EmployeesApiWeb, :controller

  alias EmployeesApi.Account
  alias EmployeesApi.Account.User

  import Bcrypt, only: [check_pass: 2]

  action_fallback EmployeesApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    user = Account.get_user!(username)

    case check_pass(user, password) do
      {:ok, _} ->
        render(conn, :show, user: user)

      {:error, _} ->
        conn
        |> put_status(:unauthorized)
        |> render(:unauthorized)
    end
  end
end

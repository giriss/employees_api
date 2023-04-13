defmodule EmployeesApiWeb.Authenticate do
  import Plug.Conn, only: [get_req_header: 2]
  alias EmployeesApiWeb.UserJSON
  use Joken.Config
  use Plug.Builder

  plug :authenticate_request

  def authenticate_request(conn, _) do
    with {:ok, claims} <-
           conn
           |> get_req_header("authorization")
           |> Enum.at(0, "")
           |> String.replace("Bearer ", "")
           |> verify_and_validate do
      assign(conn, :user_id, claims["user_id"])
    else
      _ ->
        response = Jason.encode!(UserJSON.unauthorized())

        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(:unauthorized, response)
        |> halt()
    end
  end
end

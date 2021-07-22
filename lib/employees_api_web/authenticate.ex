defmodule EmployeesApi.Authenticate do
  import Plug.Conn, only: [get_req_header: 2]

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
        conn
        |> send_resp(:unauthorized, "")
        |> halt
    end
  end
end

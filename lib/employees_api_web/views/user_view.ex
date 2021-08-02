defmodule EmployeesApiWeb.UserView do
  use EmployeesApiWeb, :view
  alias EmployeesApiWeb.UserView
  import Joken
  import Joken.Config

  def render("show.json", user_map) do
    data =
      user_map.user
      |> render_one(UserView, "user.json")
      |> Map.merge(render("access_token.json", user_map).data)

    %{data: data}
  end

  def render("user.json", %{user: user}), do: %{id: user.id, username: user.username}

  def render("access_token.json", %{user: user}) do
    exp = DateTime.to_unix(DateTime.utc_now()) + 7_200
    access_token = generate_and_sign!(default_claims(), %{user_id: user.id, exp: exp})
    %{data: %{access_token: access_token, expiry: exp}}
  end

  def render("unauthorized.json", %{}) do
    %{errors: %{error: ["invalid credentials or access token"]}}
  end
end

defmodule EmployeesApiWeb.UserView do
  use EmployeesApiWeb, :view
  alias EmployeesApiWeb.UserView
  import Joken
  import Joken.Config

  def render("show.json", user_map) do
    data =
      render_one(user_map.user, UserView, "user.json")
      |> Map.merge(render("access_token.json", user_map).data)

    %{data: data}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, username: user.username}
  end

  def render("access_token.json", %{user: user}) do
    access_token = generate_and_sign!(default_claims(), %{user_id: user.id})
    %{data: %{access_token: access_token}}
  end

  def render("unauthorized.json", %{}), do: %{errors: ["invalid credentials or access token"]}
end

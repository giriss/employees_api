defmodule EmployeesApiWeb.UserView do
  use EmployeesApiWeb, :view
  alias EmployeesApiWeb.UserView
	import Joken
	import Joken.Config

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      password_hash: user.password_hash}
  end
	
	def render("access_token.json", %{user: user}) do
		access_token = default_claims |> generate_and_sign!(%{user_id: user.id})
		%{access_token: access_token}
	end
end

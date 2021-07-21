defmodule EmployeesApiWeb.UserView do
  use EmployeesApiWeb, :view
  alias EmployeesApiWeb.UserView
	import Joken
	import Joken.Config

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      password_hash: user.password_hash}
  end
	
	def render("access_token.json", %{user: user}) do
		extra_claims = %{"user_id" => user.id}
		%{access_token: generate_and_sign!(default_claims, extra_claims)}
	end
end

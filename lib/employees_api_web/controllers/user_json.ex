defmodule EmployeesApiWeb.UserJSON do
  alias EmployeesApi.Account.User

  import Joken
  import Joken.Config

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  def unauthorized(_no_param \\ %{}) do
    %{errors: %{error: ["invalid credentials or access token"]}}
  end

  defp bearer_token(%User{id: user_id}) do
    exp = DateTime.to_unix(DateTime.utc_now()) + 7_200
    token = generate_and_sign!(default_claims(), %{user_id: user_id, exp: exp})
    {token, exp}
  end

  defp data(%User{} = user) do
    {token, exp} = bearer_token(user)

    %{
      id: user.id,
      username: user.username,
      bearer_token: token,
      expiry: exp
    }
  end
end

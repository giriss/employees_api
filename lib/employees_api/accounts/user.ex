defmodule EmployeesApi.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Bcrypt, only: [add_hash: 1]

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string, redact: true
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> put_password_hash
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end

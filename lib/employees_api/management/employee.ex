defmodule EmployeesApi.Management.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :dob, :date
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :permanent, :boolean, default: false
    field :picture_id, :string

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :email, :permanent, :dob, :picture_id])
    |> validate_required([:first_name, :last_name, :email, :dob])
  end
end

defmodule EmployeesApi.EmployeeDirectory.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :dob, :date
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :permanent, :boolean, default: false
    field :status, :integer
    field :job_title_id, :id

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :email, :dob, :status, :permanent])
    |> validate_required([:first_name, :last_name, :email, :dob, :status, :permanent])
  end
end

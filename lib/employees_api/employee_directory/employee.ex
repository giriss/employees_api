defmodule EmployeesApi.EmployeeDirectory.Employee do
  use Ecto.Schema
  import Ecto.Changeset
  alias EmployeesApi.EmployeeDirectory.JobTitle

  schema "employees" do
    field :dob, :date
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :permanent, :boolean, default: false
    field :status, :integer

    belongs_to :job_title, JobTitle

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :email, :dob, :status, :permanent, :job_title_id])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :dob,
      :status,
      :permanent,
      :job_title_id
    ])
    |> foreign_key_constraint(:job_title_id)
  end
end

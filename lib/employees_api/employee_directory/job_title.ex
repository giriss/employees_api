defmodule EmployeesApi.EmployeeDirectory.JobTitle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "job_titles" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(job_title, attrs) do
    job_title
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end

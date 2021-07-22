defmodule EmployeesApi.Repo.Migrations.CreateJobTitles do
  use Ecto.Migration

  def change do
    create table(:job_titles) do
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end

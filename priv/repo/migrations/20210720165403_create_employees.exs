defmodule EmployeesApi.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :dob, :date
      add :status, :integer
      add :permanent, :boolean, default: false, null: false
      add :job_title_id, references(:job_titles, on_delete: :nothing)

      timestamps()
    end

    create index(:employees, [:job_title_id])
  end
end

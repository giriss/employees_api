defmodule EmployeesApi.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :permanent, :boolean, default: false, null: false
      add :dob, :date
      add :picture_id, :string

      timestamps()
    end
  end
end

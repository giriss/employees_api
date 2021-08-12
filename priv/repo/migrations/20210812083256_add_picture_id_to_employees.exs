defmodule EmployeesApi.Repo.Migrations.AddPictureIdToEmployees do
  use Ecto.Migration

  def change do
    alter table("employees") do
      add :picture_id, :text
    end
  end
end

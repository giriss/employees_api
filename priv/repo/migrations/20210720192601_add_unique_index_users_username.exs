defmodule EmployeesApi.Repo.Migrations.AddUniqueIndexUsersUsername do
  use Ecto.Migration

  def change do
		create unique_index(:users, :username)
  end
end

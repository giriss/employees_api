defmodule EmployeesApi.EmployeeDirectory do
  @moduledoc """
  The EmployeeDirectory context.
  """

  import Ecto.Query, warn: false
  alias EmployeesApi.Repo

  alias EmployeesApi.EmployeeDirectory.JobTitle

  @doc """
  Returns the list of job_titles.

  ## Examples

      iex> list_job_titles()
      [%JobTitle{}, ...]

  """
  def list_job_titles do
    Repo.all(JobTitle)
  end

  @doc """
  Gets a single job_title.

  Raises `Ecto.NoResultsError` if the Job title does not exist.

  ## Examples

      iex> get_job_title!(123)
      %JobTitle{}

      iex> get_job_title!(456)
      ** (Ecto.NoResultsError)

  """
  def get_job_title!(id), do: Repo.get!(JobTitle, id)

  @doc """
  Creates a job_title.

  ## Examples

      iex> create_job_title(%{field: value})
      {:ok, %JobTitle{}}

      iex> create_job_title(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_job_title(attrs \\ %{}) do
    %JobTitle{}
    |> JobTitle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a job_title.

  ## Examples

      iex> update_job_title(job_title, %{field: new_value})
      {:ok, %JobTitle{}}

      iex> update_job_title(job_title, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_job_title(%JobTitle{} = job_title, attrs) do
    job_title
    |> JobTitle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a job_title.

  ## Examples

      iex> delete_job_title(job_title)
      {:ok, %JobTitle{}}

      iex> delete_job_title(job_title)
      {:error, %Ecto.Changeset{}}

  """
  def delete_job_title(%JobTitle{} = job_title) do
    Repo.delete(job_title)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking job_title changes.

  ## Examples

      iex> change_job_title(job_title)
      %Ecto.Changeset{data: %JobTitle{}}

  """
  def change_job_title(%JobTitle{} = job_title, attrs \\ %{}) do
    JobTitle.changeset(job_title, attrs)
  end

  alias EmployeesApi.EmployeeDirectory.Employee

  @doc """
  Returns the list of employees.

  ## Examples

      iex> list_employees()
      [%Employee{}, ...]

  """
  def list_employees do
    Repo.all(from Employee, order_by: [desc: :inserted_at])
  end

  @doc """
  Gets a single employee.

  Raises `Ecto.NoResultsError` if the Employee does not exist.

  ## Examples

      iex> get_employee!(123)
      %Employee{}

      iex> get_employee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_employee!(id), do: Repo.get!(Employee, id)

  @doc """
  Creates a employee.

  ## Examples

      iex> create_employee(%{field: value})
      {:ok, %Employee{}}

      iex> create_employee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_employee(attrs \\ %{}) do
    %Employee{}
    |> Employee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a employee.

  ## Examples

      iex> update_employee(employee, %{field: new_value})
      {:ok, %Employee{}}

      iex> update_employee(employee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_employee(%Employee{} = employee, attrs) do
    employee
    |> Employee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a employee.

  ## Examples

      iex> delete_employee(employee)
      {:ok, %Employee{}}

      iex> delete_employee(employee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_employee(%Employee{} = employee) do
    Repo.delete(employee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking employee changes.

  ## Examples

      iex> change_employee(employee)
      %Ecto.Changeset{data: %Employee{}}

  """
  def change_employee(%Employee{} = employee, attrs \\ %{}) do
    Employee.changeset(employee, attrs)
  end
end

defmodule EmployeesApiWeb.JobTitleView do
  use EmployeesApiWeb, :view
  alias EmployeesApiWeb.JobTitleView

  def render("index.json", %{job_titles: job_titles}) do
    %{data: render_many(job_titles, JobTitleView, "job_title.json")}
  end

  def render("show.json", %{job_title: job_title}) do
    %{data: render_one(job_title, JobTitleView, "job_title.json")}
  end

  def render("job_title.json", %{job_title: job_title}) do
    %{id: job_title.id, name: job_title.name, description: job_title.description}
  end
end

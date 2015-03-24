class ProjectsController < ApplicationController
  def index
    @projects = Project.
      for_user(current_user).
      order('name').
      includes(:links).
      limit(20)
  end

  def show
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to action: :index
  end
end

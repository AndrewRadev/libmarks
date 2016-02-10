class ProjectUpdatesController < ApplicationController
  before_action :require_user

  def create
    ProjectUpdateJob.perform_later(current_user.id)
    redirect_to :back, notice: "Update job was enqueued."
  end
end

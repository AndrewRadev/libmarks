class ProjectUpdatesController < ApplicationController
  before_action :require_user

  def create
    # TODO (2016-02-28) Owned repos
    ProjectUpdateJob.perform_later(current_user.id)
    redirect_to :back, notice: "Update job was enqueued."
  end
end

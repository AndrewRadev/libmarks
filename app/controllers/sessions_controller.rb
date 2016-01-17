class SessionsController < ApplicationController
  def destroy
    log_out
    redirect_to :back
  end
end

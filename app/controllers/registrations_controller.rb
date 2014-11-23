class RegistrationsController < ApplicationController
  def destroy
    registration = current_user.registrations.find(params[:id])
    registration.destroy

    flash[:notice] = "This registration method has been removed."

    redirect_to :back
  end
end

class ProfilesController < ApplicationController
  before_filter :require_user

  def show
  end

  def update
    user_params = params.require(:user).permit(:name)
    current_user.update_attributes!(user_params)
    redirect_to profile_path, notice: "Your profile was updated."
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: "Your account here has been deleted."
  end
end

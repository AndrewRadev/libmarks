class GithubController < ApplicationController
  def auth_success
    login_flow = GithubLoginFlow.new(params)
    login_flow.verify_state!(session[:github_state])
    user = login_flow.find_or_create_user!

    log_in user

    redirect_to root_path
  end
end

class GithubController < ApplicationController
  def auth_success
    login_flow = GithubLoginFlow.new(params)
    login_flow.verify_state!(session[:github_state])
    login_flow.create_user!

    redirect_to root_path
  end
end

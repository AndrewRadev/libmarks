class DashboardsController < ApplicationController
  def index
    @login_flow = GithubLoginFlow.new(scope: 'public_repo,user:email')
    session[:github_state] = @login_flow.random_state
  end
end

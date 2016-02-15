# TODO (2016-02-15) Custom response object with a sensible API, see: app/views/dashboards/index.html.erb
# TODO (2016-02-15) Own projects
# TODO (2016-02-15) Do this in the background, with the ProjectUpdateJob
class GithubProjects
  def initialize(user)
    @user = user
  end

  def fetch(page: 1)
    @user.github_client.activity.starring.starred(page: page)
  end
end

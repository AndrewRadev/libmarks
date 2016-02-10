class ProjectUpdateJob < ActiveJob::Base
  queue_as :default

  def perform(user_id, page = 0)
    user = User.find(user_id)
    starred_repos = user.github_client.activity.starring.starred

    # TODO
    # - Get page from argument
    # - Create repos in db, enqueue next job
    # - At the end, enqueue job to sort them out?
  end
end

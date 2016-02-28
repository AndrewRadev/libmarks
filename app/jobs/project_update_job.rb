class ProjectUpdateJob < ActiveJob::Base
  queue_as :default

  def perform(user_id, page = 1)
    user = User.find(user_id)
    starred_repos = user.github_client.activity.starring.starred(page: page)

    if starred_repos.blank?
      # We're done with all the repos, finish up
      return
    end

    starred_repos.each do |repo|
      existing_project = Project.find_by(name: repo["name"])

      if existing_project
        project = existing_project
      else
        project = Project.create! do |p|
          p.name         = repo["name"]
          p.homepage_url = repo["html_url"]
          p.language     = repo["language"]
          p.github_info  = repo.except("owner", "permissions")
        end
      end

      project.update!(info_fetched_at: Time.zone.now)

      ProjectConnection.find_or_create_by!({
        project:           project,
        user:              user,
        relationship_type: 'favorite',
      })
    end

    ProjectUpdateJob.perform_later(user_id, page + 1)
  end
end

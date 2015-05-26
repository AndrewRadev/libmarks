class GithubInfoJob
  include Sidekiq::Worker

  sidekiq_options throttle: { threshold: 5000, period: 1.hour }

  def perform(bookmark_id)
    bookmark = UserBookmark.find(bookmark_id)

    user_name, repo_name = bookmark.uri.path.split('/').drop(1)
    github_response      = github_client.repos(user: user_name, repo: repo_name).get
    github_info          = github_response.body

    bookmark.info_fetched_at = Time.zone.now
    bookmark.source = 'github'
    bookmark.info = github_info.slice(
      "name", "full_name", "description", "fork", "homepage", "size",
      "language", "created_at", "updated_at", "pushed_at",
      "stargazers_count", "watchers_count", "forks_count",
      "open_issues_count", "forks", "open_issues", "watchers",
      "network_count", "subscribers_count"
    )
  rescue Github::Error::GithubError => e
    bookmark.info_fetched_at = Time.zone.now
    bookmark.source = 'github_error'
    bookmark.info = { error: e.message }
  ensure
    bookmark.save!
  end

  private

  def github_client
    @github_client ||= Github.new
  end
end

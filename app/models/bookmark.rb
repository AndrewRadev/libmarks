class Bookmark < ActiveRecord::Base
  validates :url, format: URI::regexp(['http', 'https'])

  store :info, coder: JSON

  # TODO (2014-09-23) Test using https://github.com/peter-murach/github#7-testing
  def fetch_url_info
    if uri.host == 'github.com'
      user_name, repo_name = parse_github_link
      github_response      = github_client.repos(user: user_name, repo: repo_name).get
      github_info          = github_response.body

      self.source = 'github'
      self.info = github_info.slice(
        "name", "full_name", "description", "fork", "homepage", "size",
        "language", "created_at", "updated_at", "pushed_at",
        "stargazers_count", "watchers_count", "forks_count",
        "open_issues_count", "forks", "open_issues", "watchers",
        "network_count", "subscribers_count"
      )
    end
  end

  def source
    (read_attribute('source') || '').inquiry
  end

  private

  def uri
    @uri ||= URI.parse(url)
  end

  def parse_github_link
    user, repo = uri.path.split('/').drop(1)
    [user, repo]
  end

  def github_client
    @github_client ||= Github.new
  end
end

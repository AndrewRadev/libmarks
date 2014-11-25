class UserBookmark < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :url, format: URI::regexp(['http', 'https'])

  store :info, coder: JSON

  acts_as_taggable_on :tags

  def fetch_url_info
    if uri.host == 'github.com'
      fetch_github_info
    end
  end

  def fetch_url_info_later
    UrlInfoJob.perform_later(self)
  end

  def source
    (read_attribute('source') || '').inquiry
  end

  def self.create_from_list(user, urls)
    bookmarks = urls.compact.map(&:strip).map do |url|
      new(user: user, url: url)
    end

    bookmarks.partition(&:valid?)
  end

  def self.refresh_all_info
    UserBookmark.find_each(batch_size: 100) do |bookmark|
      bookmark.fetch_url_info_later
    end
  end

  private

  def fetch_github_info
    user_name, repo_name = parse_github_link
    github_response      = github_client.repos(user: user_name, repo: repo_name).get
    github_info          = github_response.body

    self.info_fetched_at = Time.zone.now
    self.source = 'github'
    self.info = github_info.slice(
      "name", "full_name", "description", "fork", "homepage", "size",
      "language", "created_at", "updated_at", "pushed_at",
      "stargazers_count", "watchers_count", "forks_count",
      "open_issues_count", "forks", "open_issues", "watchers",
      "network_count", "subscribers_count"
    )
  rescue Github::Error::GithubError => e
    self.info_fetched_at = Time.zone.now
    self.source = 'github_error'
    self.info = {
      error: e.message
    }
  end

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
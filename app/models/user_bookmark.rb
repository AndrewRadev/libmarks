class UserBookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, presence: true
  validates :url, format: URI::regexp(['http', 'https'])

  store :info, coder: JSON

  acts_as_taggable_on :tags

  def fetch_github_info
    GithubInfoJob.perform_async(id)
  end

  def connect_project(user = nil)
    if uri.host == 'github.com'
      user_name, repo_name = uri.path.split('/').drop(1)

      self.project = Project.find_by(name: repo_name)

      if self.project.blank?
        self.project = Project.create! do |p|
          p.name     = repo_name
          p.user     = user
          p.main_url = url
        end
      end
    end
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
      bookmark.fetch_github_info
    end
  end

  def uri
    @uri ||= URI.parse(url)
  end
end

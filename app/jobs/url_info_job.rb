class UrlInfoJob < ActiveJob::Base
  queue_as :default

  def perform(bookmark)
    bookmark.fetch_url_info
    bookmark.save!
  end
end

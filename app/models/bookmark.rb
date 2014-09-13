class Bookmark < ActiveRecord::Base
  validates :url, format: URI::regexp(['http', 'https'])
end

class Project < ActiveRecord::Base
  belongs_to :user
  has_many :links, class_name: 'UserBookmark'

  def tags
    links.flat_map(&:tags).uniq
  end

  def self.for_user(user)
    where(user_id: user.id)
  end

  # TODO (2015-03-24) Store language information in project
  def language
    "VimL"
  end
end

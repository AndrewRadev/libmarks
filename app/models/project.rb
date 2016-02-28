class Project < ActiveRecord::Base
  serialize :github_info, JSON

  has_many :users, through: 'ProjectRelationship'
end

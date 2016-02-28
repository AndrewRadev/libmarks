class ProjectConnection < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  enum relationship_type: [:owner, :collaborator, :favorite]
end

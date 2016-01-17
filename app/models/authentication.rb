class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :user, :provider, presence: true
end

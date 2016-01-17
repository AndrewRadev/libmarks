class User < ActiveRecord::Base
  has_many :authentications

  validates :email, presence: true, uniqueness: true
end

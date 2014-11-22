class Registration < ActiveRecord::Base
  belongs_to :user

  validates :uid,      presence: true
  validates :provider, presence: true
  validates :user,     presence: true

  validates :uid, uniqueness: { scope: [:provider] }

  class << self
    def already_created?(auth)
      auth = auth.deep_stringify_keys
      exists?(uid: auth['uid'], provider: auth['provider'])
    end
  end
end

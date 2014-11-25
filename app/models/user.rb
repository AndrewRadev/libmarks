class User < ActiveRecord::Base
  has_many :registrations, dependent: :destroy
  has_many :bookmarks, dependent: :destroy, class_name: 'UserBookmark'

  validates :name, presence: true

  class << self
    def from_cookie(cookie)
      id, remember_value = cookie

      User.
        where(id: id, remember_token: remember_value).
        where('remember_token_expires_at > ?', Time.current).
        first
    end

    def find_or_create_from_omniauth(auth)
      find_from_omniauth(auth) || create_from_omniauth(auth)
    end

    def create_from_omniauth(auth)
      user = create! do |u|
        u.name = auth['info']['name']
      end
      user.registrations.create!(uid: auth['uid'], provider: auth['provider'])
      user
    end

    def find_from_omniauth(auth)
      registration = Registration.find_by(uid: auth['uid'], provider: auth['provider'])
      registration.try(:user)
    end
  end

  def to_cookie
    [id, remember_token]
  end

  def remember_token
    token      = read_attribute('remember_token')
    expires_at = read_attribute('remember_token_expires_at')

    if token.nil? or expires_at < Time.current
      token, _expires_at = generate_remember_token
    end

    token
  end

  def remember_token_expires_at
    expires_at = read_attribute('remember_token_expires_at')

    if expires_at.nil? or expires_at < Time.current
      _token, expires_at = generate_remember_token
    end

    expires_at
  end

  private

  def generate_remember_token
    token      = SecureRandom.hex(32)
    expires_at = 2.weeks.from_now

    update_attributes!({
      :remember_token            => token,
      :remember_token_expires_at => expires_at,
    })

    [token, expires_at]
  end
end

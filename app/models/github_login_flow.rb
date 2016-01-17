# TODO (2015-12-20) Test
class GithubLoginFlow
  attr_reader :scope, :state, :code

  def initialize(params = {})
    @scope = params[:scope]
    @state = params[:state]
    @code  = params[:code]
  end

  def auth_url(redirect_to:)
    GithubClients.app_client.authorize_url({
      redirect_uri: redirect_to,
      scope:        scope,
      state:        random_state,
    })
  end

  def verify_state!(session_state)
    raise "No state stored in session" if session_state.blank?
    raise "No state provided in params" if state.blank?
    raise "States don't match: #{session_state}, #{state}" if session_state != state
  end

  def find_or_create_user!
    token = GithubClients.app_client.get_token(code).token

    user_client = GithubClients.user_client(token)
    user_info = user_client.users.get

    # Try to find a user
    auth = Authentication.find_by(provider: 'github', token: token)
    return auth.user if auth

    # User not found, create one, with an authentication
    user = User.new({
      email:           user_info['email'],
      avatar_url:      user_info['avatar_url'],
      github_username: user_info['login'],
    })
    user.authentications.build(provider: 'github', token: token, scope: scope)
    user.save!
    user
  end

  def random_state
    @random_state ||= SecureRandom.urlsafe_base64
  end
end

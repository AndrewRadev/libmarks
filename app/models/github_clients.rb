module GithubClients
  def self.app_client
    @app_client ||= Github.new({
      client_id:     Rails.application.secrets.github_key,
      client_secret: Rails.application.secrets.github_secret,
    })
  end

  def self.user_client(token)
    Github.new({
      client_id:     Rails.application.secrets.github_key,
      client_secret: Rails.application.secrets.github_secret,
      oauth_token:   token,
    })
  end
end

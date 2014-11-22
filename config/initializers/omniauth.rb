secrets = Rails.application.secrets

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, secrets.facebook_key, secrets.facebook_secret
  provider :twitter,  secrets.twitter_key,  secrets.twitter_secret
  provider :github,   secrets.github_key,   secrets.github_secret
end

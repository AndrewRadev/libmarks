if Rails.env.development?
  require 'sidekiq/testing/inline'
  Sidekiq::Testing.inline!
end

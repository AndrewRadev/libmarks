require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'dashboards#index'

  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/auth/github/callback' => 'github#auth_success', as: 'github_auth_success'

  resource :session, only: [:destroy]
  resource :project_updates, only: [:create]
end

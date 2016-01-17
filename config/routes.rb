Rails.application.routes.draw do
  root to: 'dashboards#index'

  get '/auth/github/callback' => 'github#auth_success', as: 'github_auth_success'

  resource :session, only: [:destroy]
end

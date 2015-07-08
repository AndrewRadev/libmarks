require 'sidekiq/web'

Rails.application.routes.draw do
  root 'projects#index'

  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/pages/login'             => 'pages#login', as: 'login_page'
  get '/auth/:provider/callback' => 'omniauth#callback'
  delete '/signout'              => 'sessions#destroy', as: :logout

  resource :profile
  resource :search
  resources :registrations
  resources :projects

  resources :user_bookmarks do
    member do
      put :update_info
    end

    collection do
      get :new_batch
      post :create_batch
    end
  end

  resources :tags do
    collection do
      get :prefetch
      get :search
    end
  end
end

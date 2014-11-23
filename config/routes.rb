Rails.application.routes.draw do
  root 'bookmarks#index'

  get '/pages/login'             => 'pages#login', as: 'login_page'
  get '/auth/:provider/callback' => 'omniauth#callback'
  delete '/signout'              => 'sessions#destroy', as: :logout

  resource :profile
  resource :search
  resources :registrations

  resources :bookmarks do
    member do
      put :update_info
    end

    collection do
      get :new_batch
      post :create_batch
    end
  end
end

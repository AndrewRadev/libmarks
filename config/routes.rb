Rails.application.routes.draw do
  root 'bookmarks#index'

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

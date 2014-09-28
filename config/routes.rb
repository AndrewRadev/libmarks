Rails.application.routes.draw do
  root 'bookmarks#index'

  resources :bookmarks do
    member do
      put :update_info
    end
  end
end

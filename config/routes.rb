Rails.application.routes.draw do
  root 'bookmarks#new'

  resources :bookmarks
end

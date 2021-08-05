Rails.application.routes.draw do
  root 'static_pages#top'
  root :to => 'users#index'
  resources :users
end

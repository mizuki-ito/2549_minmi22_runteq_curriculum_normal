Rails.application.routes.draw do
  root 'static_pages#top'
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :boards do
    resources :comments, only: %i[create update destroy], shallow: true
    collection do
      get :bookmarks
    end
    resource :bookmarks, only: %i[create destroy]
  end
end

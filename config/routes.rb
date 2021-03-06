Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'static_pages#top'
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  resources :boards do
    resources :comments, only: %i[create update destroy], shallow: true
    collection do
      get :bookmarks
    end
    resource :bookmarks, only: %i[create destroy]
  end

  namespace :admin do
    root 'dashboards#index'
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :boards, only: [:index, :show, :edit, :update, :destroy]
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
  end
end

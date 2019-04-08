Rails.application.routes.draw do
  # root to: 'pages#home'
  namespace :api do
    namespace :v1 do
      post '/login', to: 'login#login'

      resources :meals, only: [:index, :create]

      resources :orders, only: [:show]

      resources :users, only: [:show, :create, :update]

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

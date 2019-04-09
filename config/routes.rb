Rails.application.routes.draw do
  # root to: 'pages#home'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :orders, only: [:index, :show] do
        resources :order_items, only: [:index, :show]
      end

      resources :meals, only: [:index, :show, :create]
      resources :dishes, only: [:index, :show] do
        resources :doses, only: [:index]
      end

      resources :users, only: [:show, :create, :update]

      post '/login', to: 'login#login'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

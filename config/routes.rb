Rails.application.routes.draw do
  # root to: 'pages#home'
  namespace :api do
    namespace :v1 do
      post '/login', to: 'login#login'

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

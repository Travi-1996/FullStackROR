Rails.application.routes.draw do
  scope path: "/api" do
    #users controller
    root :to => "users#index"

    get '/users/login', to: 'users#login'
    get 'u/sers/forgot-password', to: 'users#forgot_password'
    resources :users
    
    #roles controller
    resources :roles
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

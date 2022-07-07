Rails.application.routes.draw do
  scope path: "/api" do
    root :to => "users#index"
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

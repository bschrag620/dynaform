Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "application#index", as: "root"

  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#delete", as: "logout"

  get "/signup", to: "users#new", as: "signup"
  post "/signup", to: "users#create"
end

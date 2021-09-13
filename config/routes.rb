Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "application#index", as: "root"

  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#delete", as: "logout"

  get "/signup", to: "users#new", as: "signup"
  post "/signup", to: "users#create"

  post "/dyna_forms/:id", to: "dyna_forms#details", as: :dyna_form_details
  delete "form_inputs/:id", to: "form_inputs#destroy", as: :form_input_delete
  post "form_inputs/:id/edit",to: "form_inputs#edit", as: :form_input_edit

  resources :dyna_forms do
    resources :form_inputs, except: [:destroy]
    post 'form_inputs/sample', to: 'form_inputs#sample', as: "form_inputs_sample"
  end

  get "/dashboard", to: "dashboard#index", as: "dashboard"

end

Rails.application.routes.draw do
  # GET /about
  get "/about", to: "about#index"
  get "/", to: "main#index"
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

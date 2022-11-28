Rails.application.routes.draw do
  get root to: "main#index"
  get "about", to: "about#index"

  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  delete "logout", to: "sessions#destroy"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

 get "sale", to: "sales#new"
 post "sale", to: "sales#search" 
 delete "sale", to: "sales#destroy"
 get "sell", to: "sales#create"

 get "index", to: "sales#index"

#  get "products", to: "products#index" 
#  get "products/:id", to: "products#show"
 resources :products
end

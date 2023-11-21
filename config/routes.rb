Rails.application.routes.draw do

  devise_for :users
  root to: "boats#index"
  post "search", to: "boats#search"

 resources :boats
end

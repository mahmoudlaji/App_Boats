Rails.application.routes.draw do
  devise_for :users
  root to: "boats#index"

  resources :boats do
    collection do
      get :search
    end
  end
end

Rails.application.routes.draw do
  devise_for :users
  resources :items do
    member do
      patch :complete
    end
    post :delete_all, on: :collection
  end
  root "items#index"
end

Rails.application.routes.draw do
  # API resources
  namespace :api, defaults: { format: :json } do
    resources :clients, only: [ :index, :create, :destroy ]
    resources :wallets, only: [ :index, :show, :create, :destroy ]
  end
end

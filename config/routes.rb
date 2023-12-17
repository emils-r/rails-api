Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :clients, only: [ :index, :create, :destroy ]
  end
end

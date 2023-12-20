Rails.application.routes.draw do
  # API resources
  namespace :api, defaults: { format: :json } do
    resources :clients
    resources :wallets, only: [ :index, :show, :create, :destroy ]

    post '/transfer' => 'transfer#transfer_funds'
    post '/transfer/exchange-rate' => 'transfer#exchange_rate'
  end
end

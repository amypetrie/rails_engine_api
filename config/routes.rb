Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find_all", to: "search#index"
        get "/find", to: "search#show"

        get "/revenue", to: "revenue#show"
        get "/most_revenue", to: "revenue#index"

        get "/most_items", to: "items#index"
      end
      namespace :customers do
        get "/find_all", to: "search#index"
        get "/find", to: "search#show"
      end
      namespace :transactions do
        get "/find_all", to: "search#index"
        get "/find", to: "search#show"
      end
      namespace :invoices do
        get "/find_all", to: "search#index"
        get "/find", to: "search#show"
      end
      namespace :invoice_items do
        get "/find_all", to: "search#index"
        get "/find", to: "search#show"
      end
      namespace :items do
        get "/find_all", to: "search#index"
        get "/find", to: "search#show"
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end
      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end
      resources :items, only: [:index, :show] do
        resource :merchant, only: [:show]
        resources :invoices_items, only: [:index]
      end
      resources :invoices, only: [:index, :show] do
        resource :customer, only: [:show]
        resource :merchant, only: [:show]
        resources :items, only:  [:index]
        resources :transactions, only:  [:index]
        resources :invoice_items, only:  [:index]
      end
      resources :invoice_items, only: [:index, :show] do
        resource :invoice, only: [:show]
        resource :item, only: [:show]
      end
      resources :transactions, only: [:index, :show] do
        resource :invoice, only: [:show]
      end
    end
  end

end

# GET /api/v1/merchants/most_revenue?quantity=x

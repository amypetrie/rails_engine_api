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
      resources :merchants, only: [:index, :show] do
        get "/random", to: "merchants#show"
      end
    end
  end

end

# GET /api/v1/merchants/most_revenue?quantity=x

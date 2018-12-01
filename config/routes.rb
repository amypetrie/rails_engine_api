Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/random", to: "merchants#index"

        get "/find_all", to: "search#index" #has_search_params\
        get "/find", to: "search#show" #has_search_params

        get "/revenue", to: "revenue#show" #has_search_params
        get "/most_revenue", to: "revenue#index"

        get "/most_items", to: "items#index" #has_search_params
      end
    resources :merchants, only: [:index, :show]
    end
  end

end

# GET /api/v1/merchants/most_revenue?quantity=x

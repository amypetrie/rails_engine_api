Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: "search#show"
        get '/most_revenue', to: "stats#index", params: "most_revenue"
        get '/most_items', to: "stats#index", params: "most_items"
        get '/revenue', to: "stats#index", params: "revenue"
      end
      resources :merchants, only: [:index, :show]
    end
  end

end

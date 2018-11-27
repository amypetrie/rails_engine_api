Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only:[:index, :show]
      namespace :merchants do
        resources :search, only:[:show]
      end
    end
  end

end

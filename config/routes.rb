Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :dictionaries, except: :destroy do
        post :translate, on: :collection
      end
    end
  end
end

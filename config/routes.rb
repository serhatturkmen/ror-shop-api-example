Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/', to: 'welcome#index'

      # menu_items route
      get '/menu_items', to: 'menu_items#index'
      get '/menu_items/:id', to: 'menu_items#show'
      post '/menu_items', to: 'menu_items#create'
      patch '/menu_items/:id', to: 'menu_items#update'
      delete '/menu_items/:id', to: 'menu_items#destroy'

      # menu_categories route
      get '/menu_categories', to: 'menu_categories#index'
      get '/menu_categories/:id', to: 'menu_categories#show'
      post '/menu_categories', to: 'menu_categories#create'
      patch '/menu_categories/:id', to: 'menu_categories#update'
      delete '/menu_categories/:id', to: 'menu_categories#destroy'
    end
  end

  match '*unmatched', to: 'application#not_found_routing', via: :all
end

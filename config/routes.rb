Rails.application.routes.draw do
  get '/menu_items', to: 'menu_items#index'
  get '/menu_items/:id', to: 'menu_items#show'
  post '/menu_items', to: 'menu_items#create'
  patch '/menu_items/:id', to: 'menu_items#update'
  delete '/menu_items/:id', to: 'menu_items#destroy'
end

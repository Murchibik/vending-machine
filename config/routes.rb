Rails.application.routes.draw do
  resources :products, except: %i[show] do
    patch '/restock', to: 'products#restock'
  end

  get '/balance', to: 'home#my_balance'
  post '/input', to: 'home#input'
  post '/pick', to: 'home#pick'
  patch '/cancel', to: 'home#cancel'

  root 'products#index'
end

Rails.application.routes.draw do
  resources :products, except: %i[show]
  root 'products#index'
end

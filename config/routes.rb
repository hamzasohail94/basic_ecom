Rails.application.routes.draw do
  resources :products do
    member do
      post 'add_to_cart', to: 'carts#add_to_cart'
    end
  end
  get '/users/signin', to: 'users#signin'
  post '/users/signin', to: 'users#create_user_session'
  get '/users/signup', to: 'users#signup'
  post '/users/register', to: 'users#register'
  delete '/users/signout', to: 'users#signout'
  post '/carts/checkout', to: 'carts#checkout'
  get '/carts/view_cart', to: 'carts#view_cart'
  root to: 'products#index'
end

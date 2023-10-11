Rails.application.routes.draw do
  devise_for :users
  root 'recipes#public_recipes'
  resources :recipes do
    member do
      post 'add_ingredient' # Use 'get' or 'post' as needed
      post 'destroy_ingredient'
    end
  end
  resources :foods
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

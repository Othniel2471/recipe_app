Rails.application.routes.draw do
  devise_for :users
  
  # Existing routes for foods and recipes
  resources :foods
  resources :recipes do
    put 'toggle_public', on: :member
    member do
      get 'shoping_list'
    end
  end
  resources :food_recipes, only: [:new, :create, :destroy]
  root 'recipes#public'
end

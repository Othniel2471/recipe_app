Rails.application.routes.draw do
  devise_for :users
  
  # Existing routes for foods and recipes
  resources :foods
  resources :recipes do
    put 'toggle_public', on: :member
    resources :food_recipes, only: [:new, :create, :destroy]
  end
  root 'recipes#public'
end

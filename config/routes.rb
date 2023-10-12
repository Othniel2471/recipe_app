Rails.application.routes.draw do
  devise_for :users
  
  # Existing routes for foods and recipes
  resources :food_recipes
  resources :foods
  resources :recipes do
    put 'toggle_public', on: :member
    resources :food_recipes
  end

  # New routes
  resources :recipes do
    member do
      get 'new_ingredient', to: 'recipes#new_ingredient'
      post 'add_ingredient', to: 'recipes#add_ingredient'
    end
  end
  get 'general_shoping_list', to: 'general_shoping#index'

  # Root route
  root 'recipes#public'
end

class Food < ApplicationRecord
  belongs_to :user
  has_many :food_recipes
  has_many :recipes, through: :food_recipes, class_name: 'Recipe', foreign_key: 'recipe_id'
end

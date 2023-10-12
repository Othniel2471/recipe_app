class Food < ApplicationRecord
  belongs_to :user
  has_many :food_recipes, through: :food_recipes, class_name: 'Recipe', foreign_key: 'recipe_id'

  accepts_nested_attributes_for :food_recipes
end

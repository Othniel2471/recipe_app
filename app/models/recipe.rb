class Recipe < ApplicationRecord
  belongs_to :user
  has_many :food_recipes
  has_many :foods, through: :food_recipes, class_name: 'Food', foreign_key: 'food_id'
end

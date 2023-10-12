class Recipe < ApplicationRecord
  belongs_to :user
  has_many :food_recipes, through: :food_recipes, class_name: 'Food', foreign_key: 'food_id'

  accepts_nested_attributes_for :food_recipes
end

class Food < ApplicationRecord
  # Attributes
  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  belongs_to :user
  has_many :food_recipes
  has_many :recipes, through: :food_recipes, class_name: 'Recipe', foreign_key: 'recipe_id'
end

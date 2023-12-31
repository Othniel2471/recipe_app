class Recipe < ApplicationRecord
  # Attributes
  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :cooking_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true

  belongs_to :user
  has_many :food_recipes, dependent: :destroy
  has_many :foods, through: :food_recipes, class_name: 'Food', foreign_key: 'food_id'
end

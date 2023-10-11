class FoodRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def value
    quantity * food.price
  end
end

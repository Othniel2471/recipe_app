class FoodRecipe < ApplicationRecord
  belongs_to :recipe, class_name: 'Recipe', foreign_key: 'recipe_id'
  belongs_to :food, class_name: 'Food', foreign_key: 'food_id'
   # Attributes
   validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def value
    quantity * food.price
  end
end

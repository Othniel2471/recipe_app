class Food < ApplicationRecord
  belongs_to :user
  has_many :food_recipes
  has_many :recipes, through: :food_recipes, class_name: 'Recipe', foreign_key: 'recipe_id'

  def value
    # Initialize a variable to hold the calculated value
    total_value = 0

    # Iterate over associated FoodRecipes and calculate the total value
    food_recipes.each do |food_recipe|
      total_value += food_recipe.quantity * price
    end

    total_value
  end
end

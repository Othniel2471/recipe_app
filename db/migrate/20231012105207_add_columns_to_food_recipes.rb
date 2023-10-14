class AddColumnsToFoodRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :food_recipes, :food, null: false, foreign_key: true
    add_reference :food_recipes, :recipe, null: false, foreign_key: true
    add_column :food_recipes, :quantity, :integer, null: false, default: 0
  end
end

require 'rails_helper'

RSpec.describe FoodRecipe, type: :model do
  before(:each) do
    @user = User.new(name: 'Dave')
    @recipe = Recipe.new(name: 'Example Recipe', description: 'Example Description', public: true,
                         preparation_time: 10, cooking_time: 10)
    @food = Food.new(name: 'Example Food', measurement_unit: 'g', price: 10, quantity: 100)
    @food_recipe = FoodRecipe.new(food_id: @food.id, recipe_id: @recipe.id, quantity: 100)
  end

  context 'when adding a food_recipe' do
    it 'should display food_recipe quantity' do
      expect(@food_recipe.quantity).to eq(100)
    end

    it 'should display food_recipe food_id' do
      expect(@food_recipe.food_id).to eq(@food.id)
    end

    it 'should display food_recipe recipe_id' do
      expect(@food_recipe.recipe_id).to eq(@recipe.id)
    end

    it 'should have food' do
      expect(@food_recipe.food).to eq(@food)
    end

    it 'should have recipe' do
      expect(@food_recipe.recipe).to eq(@recipe)
    end

    it 'should have many food_recipes' do
      expect(@food_recipe.food_recipes).to eq([])
    end
  end
end

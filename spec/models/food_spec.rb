require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:each) do
    @user = User.new(name: 'Dave')
    @recipe = Recipe.new(name: 'Example Recipe', description: 'Example Description', public: true,
                         preparation_time: 10, cooking_time: 10)
    @food = Food.new(name: 'Example Food', measurement_unit: 'g', price: 10, quantity: 100)
    @food_recipe = FoodRecipe.new(food_id: @food.id, recipe_id: @recipe.id, quantity: 100)
  end

  context 'when adding a food' do
    it 'should display food name' do
      expect(@food.name).to eq('Example Food')
    end

    it 'should display food measurement_unit' do
      expect(@food.measurement_unit).to eq('g')
    end

    it 'should display food price' do
      expect(@food.price).to eq(10)
    end

    it 'should display food quantity' do
      expect(@food.quantity).to eq(100)
    end

    it 'should have user_id' do
      expect(@food.user_id).to eq(nil)
    end

    it 'should have food_recipes' do
      expect(@food.food_recipes).to eq([])
    end
  end
end

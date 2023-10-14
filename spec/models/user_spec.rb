require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: 'Example User')
    @recipe = Recipe.new(name: 'Example Recipe', description: 'Example Description', public: true,
                         preparation_time: 10, cooking_time: 10)
    @food = Food.new(name: 'Example Food', measurement_unit: 'g', price: 10, quantity: 100)
    @food_recipes = @recipe.food_recipes.new(food_id: @food.id, quantity: 100)
  end

  it 'should have name' do
    expect(@user.name).to eq('Example User')
  end

  it 'should have recipe' do
    expect(@recipe.name).to eq('Example Recipe')
  end

  it 'should have food' do
    expect(@food.name).to eq('Example Food')
  end

  it 'should have food_recipes' do
    expect(@food_recipes.quantity).to eq(100)
  end

  it 'have many recipes' do
    expect(@user.recipes).to eq([])
  end

  it 'should have many foods' do
    expect(@user.foods).to eq([])
  end

  it 'should validate presence of email' do
    expect(@user).to_not be_valid
  end
end

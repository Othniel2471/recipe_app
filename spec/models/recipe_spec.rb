require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @user = User.new(name: 'Dave')
    @recipe = Recipe.new(name: 'Example Recipe', description: 'Example Description', public: true,
                         preparation_time: 10, cooking_time: 10)
  end

  context 'when adding a recipe' do
    it 'should display recipe name' do
      expect(@recipe.name).to eq('Example Recipe')
    end

    it 'should display recipe description' do
      expect(@recipe.description).to eq('Example Description')
    end

    it 'should display preparation time' do
      expect(@recipe.preparation_time).to eq(10)
    end

    it 'should display cooking time' do
      expect(@recipe.cooking_time).to eq(10)
    end

    it 'should have food_recipes' do
      expect(@recipe.food_recipes).to eq([])
    end

    it 'should have user_id' do
      expect(@recipe.user_id).to eq(nil)
    end
  end
end

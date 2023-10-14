require 'rails_helper'

RSpec.describe 'recipes/show.html.erb', type: :feature do
  let(:user) { User.create(name: 'otsama', email: 'test@test.com', password: '121212') }

  describe 'Testing integration specs for recipes show page' do
    before :each do
      recipe = Recipe.create(name: 'Pasta', preparation_time: 20, cooking_time: 10, description: 'testie',
                             public: true, user:)

      # Mark user as confirmed
      user.confirm

      login_as(user, scope: :user)

      # Visit the specific recipe's show page
      visit recipe_path(recipe)
    end

    it 'can see recipe name' do
      expect(page).to have_content('Pasta')
    end

    it 'can see recipe description' do
      expect(page).to have_content('testie')
    end

    it 'should display the preparation time' do
      expect(page).to have_content('Preparation time: 20')
    end

    it 'should display the cooking time' do
      expect(page).to have_content('Cooking time: 10')
    end

    it 'shows add ingredients button' do
      expect(page).to have_content('Add Ingredients')
    end

    it 'shows generate shopping list button' do
      expect(page).to have_content('Generate shopping list')
    end
  end
end

require 'rails_helper'

RSpec.describe 'recipes/index.html.erb', type: :feature do
  let(:user) { User.create(name: 'John', email: 'test@test.com', password: '121212') }
  let(:user2) { User.create(name: 'John2', email: 'john@gmail.com', password: '121212') }

  describe 'Testing integration specs for recipes index page' do
    before :each do
      Recipe.create(name: 'Pizza', preparation_time: 20, cooking_time: 10, description: 'test', public: true,
                    user:)
      Recipe.create(name: 'Pasta', preparation_time: 20, cooking_time: 10, description: 'testie', public: true,
                    user: user2)

      # Mark user2 as confirmed
      user2.confirm

      login_as(user2, scope: :user)
      visit recipes_path
    end

    it 'can see recipe name' do
      expect(page).to have_content('Pasta')
    end

    it 'can see recipe description' do
      expect(page).to have_content('testie')
    end

    it 'can show remove button' do
      expect(page).to have_content('Remove')
    end

    it 'can show view button' do
      expect(page).to have_content('View')
    end

    it 'can show add recipe link' do
      expect(page).to have_content('Add new recipe')
    end
  end
end

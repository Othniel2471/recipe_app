require 'rails_helper'

RSpec.describe 'Foods', type: :feature do
  before(:each) do
    @user = User.create!(name: 'David', email: 'david@gmail.com', password: 'password',
                         password_confirmation: 'password')
    @food = Food.create!(name: 'Bread', measurement_unit: 'loaf', price: 1.99, quantity: 1, user_id: @user.id)
    @food2 = Food.create!(name: 'Milk', measurement_unit: 'gallon', price: 2.99, quantity: 1, user_id: @user.id)
    @food3 = Food.create!(name: 'Eggs', measurement_unit: 'dozen', price: 1.99, quantity: 1, user_id: @user.id)
    @food4 = Food.create!(name: 'Cheese', measurement_unit: 'pound', price: 3.99, quantity: 1, user_id: @user.id)
    @food5 = Food.create!(name: 'Butter', measurement_unit: 'pound', price: 2.99, quantity: 1, user_id: @user.id)
  end

  describe 'food index page' do
    it 'shows all foods' do
      visit foods_path
      expect(page).to have_content('Bread')
      expect(page).to have_content('Milk')
      expect(page).to have_content('Eggs')
      expect(page).to have_content('Cheese')
      expect(page).to have_content('Butter')
    end
  end

  describe 'food show page' do
    it 'shows the food' do
      visit food_path(@food)
      expect(page).to have_content('Bread')
      expect(page).to have_content('loaf')
      expect(page).to have_content('1.99')
      expect(page).to have_content('1')
    end
  end

  describe 'food new page' do
    it 'shows the new food form' do
      visit new_food_path
      expect(page).to have_content('New food')
    end
  end
end

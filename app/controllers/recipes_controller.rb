class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy add_ingredient destroy_ingredient]
  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show; end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end
  def public_recipes
    @recipes = Recipe.where(public: true)
  end

  def add_ingredient
    @food = Food.find(params[:food_id])
    @recipe.food << @food
  end

  def destroy_ingredient
    @food = Food.find(params[:food_id])
    @recipe.food.delete(@food)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end

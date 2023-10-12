class FoodRecipesController < ApplicationController
    before_action :set_recipe, only: %i[ show edit update destroy]
    before_action :set_food, only: %i[show edit update destroy]
    before_action :authenticate_user!, except: [:public]
    before_action :food_recipe_params, only: %i[create]
  
  def new
    @food_recipe = FoodRecipe.new 
    @foods = Food.all
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @food = Food.find(food_recipe_params[:food_id])
    @food_recipe = FoodRecipe.new(food_recipe_params)
    @food_recipe.food = @food
    @recipe = Recipe.find(food_recipe_params[:recipe_id])
    @food_recipe.recipe = @recipe
    if @food_recipe.save
      redirect_to recipe_url(@recipe), notice: 'food was successfully addedn to recipe.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end



  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def food_recipe_params
    params.require(:food_recipe).permit(:food_id, :recipe_id, :quantity)
  end
end

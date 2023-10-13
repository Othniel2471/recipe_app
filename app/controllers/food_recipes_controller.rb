class FoodRecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
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
    @recipe = Recipe.find(food_recipe_params[:recipe_id])
    existing_food_recipe = @recipe.food_recipes.find_by(food_id: @food.id)

    if existing_food_recipe
      # If the ingredient already exists, update its quantity
      existing_food_recipe.quantity += food_recipe_params[:quantity].to_i
      if existing_food_recipe.save
        redirect_to recipe_path(@recipe), notice: 'Ingredient quantity updated.'
      else
        # Handle any errors with saving the existing ingredient
        render :new, status: :unprocessable_entity
      end
    else
      # If the ingredient doesn't exist, create a new one
      @food_recipe = FoodRecipe.new(food_recipe_params)
      @food_recipe.food = @food
      @food_recipe.recipe = @recipe

      if @food_recipe.save
        redirect_to recipe_path(@recipe), notice: 'Ingredient added to the recipe.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @food_recipe = FoodRecipe.find(params[:food_recipe_id])
    @recipe = Recipe.find(params[:recipe_id])
    @food_recipe.destroy

    redirect_to recipe_path(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def food_recipe_params
    params.require(:food_recipe).permit(:food_id, :recipe_id, :quantity)
  end
end

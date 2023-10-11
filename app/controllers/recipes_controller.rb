class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [:public]

  def public
    @public_page = true
    @recipes = Recipe.where(public: true).order(created_at: :desc)
    render :index
  end

  def index
    @recipes = Recipe.where(user_id: current_user.id).order(created_at: :desc)
  end

  def show
    @recipe = set_recipe
    @recipe_foods = @recipe.food
    @food = @recipe_foods.first
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params.merge(user_id: current_user.id))
    if @recipe.save
      redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: params[:recipe][:public])
    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  # def add_ingredient
  #   @recipe = set_recipe
  #   @food = Food.find(params[:recipe][:food_id])
  #   @recipe.food << @food
  #   @recipe.quantity = params[:recipe][:quantity] # Set the quantity
  #   @recipe.save # Save the recipe with the quantity
  # end


  def add_ingredient
    @recipe = set_recipe
    @food = Food.find(params[:recipe][:food_id])
    @recipe.food << @food
  end

  # def add_ingredient
  #   @recipe = set_recipe
  #   @food = Food.find(params[:food_id])
  #   @recipe.food << @food
  # end

  # def new_ingredient
  #   @recipe = set_recipe
  #   @food = Food.new
  # end

  def new_ingredient
    @recipe = set_recipe
    @food = Food.new
  end

  def destroy_ingredient
    @food = Food.find(params[:food_id])
    @recipe.food.delete(@food)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id, :quantity)
  end
end

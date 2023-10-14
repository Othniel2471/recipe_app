class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [:public]

  def public
    @public_page = true
    @recipes = Recipe.includes(%i[foods food_recipes user]).where(public: true).order('created_at DESC')
    @public_recipe_data_list = []
    @recipes.each do |recipe|
      public_recipe_data = {}
      public_recipe_data[:user] = recipe.user.name
      public_recipe_data[:recipe] = recipe
      public_recipe_data[:recipe_name] = recipe.name
      public_recipe_data[:food_count] = recipe.foods.length
      public_recipe_data[:total_price] = recipe.food_recipes.reduce(0) do |total_price, food_recipe|
        total_price + (food_recipe.food.price * food_recipe.quantity)
      end
      @public_recipe_data_list << public_recipe_data
    end
  end

  def shoping_list
    @recipe = Recipe.includes(:foods, :food_recipes, :user).find(params[:id])
    @recipe_shoping_list_data = {}
    @recipe_shoping_list_data[:recipe_name] = @recipe.name
    @recipe_shoping_list_data[:food_count] = @recipe.foods.length
    p @recipe.food_recipes
    @recipe_shoping_list_data[:foods_data] = @recipe.food_recipes.map do |food_recipe|
      {
        name: food_recipe.food.name,
        quantity: food_recipe.quantity,
        price: food_recipe.food.price * food_recipe.quantity
      }
    end
    @recipe_shoping_list_data[:total_price] = @recipe.food_recipes.reduce(0) do |total_price, food_recipe|
      total_price + (food_recipe.food.price * food_recipe.quantity)
    end
  end

  def index
    @recipes = Recipe.where(user_id: current_user.id).order(created_at: :desc)
  end

  def show
    @recipe = Recipe.includes(:food_recipes).find(params[:id])
    @food_recipes = @recipe.food_recipes
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

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    respond_to do |format|
      if params[:public].present?
        if @recipe.update(public: params[:public])
          format.html { redirect_to recipe_url(@recipe), notice: 'Public attribute was successfully updated.' }
          format.json { render :show, status: :ok, location: @recipe }
        else
          format.html { render :edit }
          format.json { render json: @recipe.errors, status: :unprocessable_entity }
        end
      elsif @recipe.update(recipe_params)
        # Handle other attributes here
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe attributes were successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
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

  def add_ingredient
    @recipe = Recipe.find(params[:recipe_id])
    recipe_food_params = recipe_ingredient_params

    # Create a new RecipeFood record to associate the selected food with the recipe
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      flash[:success] = 'Ingredient added successfully'
      redirect_to @recipe
    else
      render 'add_ingredient'
    end
  end

  def new_ingredient
    @recipe = set_recipe
    @food = Food.new
  end

  def destroy_ingredient
    @food = Food.find(params[:food_id])
    @recipe.food.delete(@food)
  end

  private

  def recipe_ingredient_params
    params.require(:recipe).permit(food_recipes_attributes: %i[quantity food_id])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id, :quantity)
  end
end

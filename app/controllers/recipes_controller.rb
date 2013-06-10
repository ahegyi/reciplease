class RecipesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def new
    if !params[:recipe].nil? && !params[:recipe].empty?
      @recipe = Recipe.new(params[:recipe])
    else
      @recipe = Recipe.new
    end
  end

  def create
    @recipe = Recipe.new(params[:recipe])

    respond_to do |format|
      if @recipe.save

        # parse out into Ingredients
        @recipe.add_ingredients_from_self

        format.html do
          redirect_to @recipe, notice: "<b>#{@recipe.name}</b> has been added!".html_safe
        end
        format.json do
          render json: @recipe, status: :created, location: @recipe
        end
      else
        format.html do
          flash[:error] = "Error saving recipe."
          render action: "new"
        end
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

end

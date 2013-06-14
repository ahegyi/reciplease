class RecipesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      format.html { }
      format.json { render json: @recipe }
    end
  end

  def edit
    recipe = Recipe.find(params[:id])
    if current_user.recipes.include? recipe
      @recipe = recipe
    else
      redirect_to recipes_url
    end
  end

  def new
    if !params[:recipe].nil? && !params[:recipe].empty?
      @recipe = Recipe.new(params[:recipe])
    else
      @recipe = Recipe.new
    end
  end

  def create
    @recipe = Recipe.new(params[:recipe].except(:document))
    # attach to the current user
    @recipe.user = current_user
    @recipe.document = params[:recipe][:document]

    respond_to do |format|
      if @recipe.save

        # asynchronously fill out recipe object from the document
        if @recipe.document.present?
          @recipe.async_create_from_document
        end

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

  # PUT /recipes/:id
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe].except(:document))
        format.html { redirect_to @recipe, notice: "<b>#{@recipe.name}</b> has been updated!".html_safe }
        format.json { render json: @recipe }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end

  end


  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    recipe = Recipe.find(params[:id])
    if current_user.recipes.include? recipe
      recipe.destroy
      respond_to do |format|
        format.html { redirect_to recipes_url }
        format.json { head :no_content }
      end
    else
      redirect_to recipes_url
    end
  end

end

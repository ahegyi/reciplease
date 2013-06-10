class HomeController < ApplicationController
  def index
    @recipes = Recipe.order("created_at DESC").limit(10)
  end
end

class AddRecipeDocumentToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :document, :string
  end
end

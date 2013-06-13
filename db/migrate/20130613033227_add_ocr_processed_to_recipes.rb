class AddOcrProcessedToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :ocr_processed, :boolean, :default => false
  end
end

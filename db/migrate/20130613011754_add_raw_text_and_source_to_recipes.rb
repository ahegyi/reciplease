class AddRawTextAndSourceToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :ocr_raw_text, :text
    add_column :recipes, :source, :text
  end
end

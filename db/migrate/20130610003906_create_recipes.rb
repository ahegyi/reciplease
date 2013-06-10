class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :author
      t.date :published_on
      t.text :description
      t.text :instructions

      t.timestamps
    end
  end
end

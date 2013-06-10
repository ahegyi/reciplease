class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :text
      t.decimal :amount
      t.string :food
      t.string :unit
      t.integer :recipe_id

      t.timestamps
    end
  end
end

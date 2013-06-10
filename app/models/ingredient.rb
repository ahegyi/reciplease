class Ingredient < ActiveRecord::Base
  attr_accessible :amount, :food, :text, :unit

  belongs_to :recipe
end

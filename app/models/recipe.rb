class Recipe < ActiveRecord::Base
  attr_accessible :author, :description, :instructions, :name, :published_on, :ingredients_text

  validates :name, :instructions, presence: true

  has_many :ingredients
end

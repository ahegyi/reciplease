class Recipe < ActiveRecord::Base
  attr_accessible :author, :description, :instructions, :name, :published_on

  validates :name, :instructions, presence: true
end

class Recipe < ActiveRecord::Base
  attr_accessible :author, :description, :instructions, :name, :published_on
end

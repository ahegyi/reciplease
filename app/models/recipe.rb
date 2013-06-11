require 'ingreedy'

class Recipe < ActiveRecord::Base
  attr_accessible :author, :description, :instructions, :name, :published_on, :ingredients_text

  mount_uploader :document, RecipeDocumentUploader

  validates :name, :user, presence: true
  validate :manual_or_document_creation

  def manual_or_document_creation
    if !document.present?
      # no document present, so was created manually
      # => ingredients_text and instructions can't be blank
      errors.add(:ingredients_text, "Ingredients can't be blank") if ingredients_text.blank?
      errors.add(:instructions, "Instructions can't be blank") if instructions.blank?
    end
  end

  has_many :ingredients
  belongs_to :user



  def parse_ingredient_text(text_to_parse)
    items = text_to_parse.split(/\s*\n+\s*/)
    ingredients = Array.new
    items.each do |item|
      ingredient = Hash.new(amount: nil, food: nil, text: nil, unit: nil)
      parsed = Ingreedy.parse(item)
      ingredient[:amount] = parsed.amount
      ingredient[:food] = parsed.ingredient
      ingredient[:unit] = parsed.unit
      ingredient[:text] = item
      ingredients << ingredient
    end

    ingredients
  end

  def add_ingredients_from_self
    ingredients_ary = parse_ingredient_text(ingredients_text)
    ingredients_ary.each do |ingredient|
      self.ingredients.create(
        amount: ingredient[:amount],
        food: ingredient[:food],
        text: ingredient[:text],
        unit: ingredient[:unit]
      )
    end
  end

end

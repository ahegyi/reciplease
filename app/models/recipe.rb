require 'ingreedy'

class Recipe < ActiveRecord::Base
  attr_accessible(
    :author,
    :description,
    :instructions,
    :name,
    :published_on,
    :ingredients_text,
    :document_cache,
    :ocr_raw_text,
    :source
  )

  mount_uploader :document, RecipeDocumentUploader

  validates :name, :user, presence: true
  # validate :manual_or_document_creation

  # def manual_or_document_creation
  #   if !document.present?
  #     # no document present, so was created manually
  #     # => ingredients_text and instructions can't be blank
  #     errors.add(:ingredients_text, "Ingredients can't be blank") if ingredients_text.blank?
  #     errors.add(:instructions, "Instructions can't be blank") if instructions.blank?
  #   end
  # end

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

  def add_ingredients_from_text(text_to_parse)
    ingredients_ary = parse_ingredient_text(text_to_parse)
    ingredients_ary.each do |ingredient|
      self.ingredients.create(
        amount: ingredient[:amount],
        food: ingredient[:food],
        text: ingredient[:text],
        unit: ingredient[:unit]
      )
    end
  end

  def add_ingredients_from_self
    add_ingredients_from_text(ingredients_text)
  end


  # these need to be in this order!
  after_save :update_ingredients_from_document
  after_save :update_ingredients_from_text

  def update_ingredients_from_document
    # if @ocr_done is not set, this may run in an infinite loop,
    # as document_changed? will be true after the first run
    # ('save' at the bottom triggers this method again)
    if document_changed? && !@ocr_done
      # run ocr stuff
      # placeholder: just set ingredients_text and instructions
      self.ingredients_text = "Created from document\n1 egg\n5 cups sugar\n12 sticks butter"
      self.instructions = "Created from document. Here are the instructions!"
      @ocr_done = true
      save
    end
  end

  def update_ingredients_from_text
    # when creating a new instance, a form could send an empty string
    # as a value for ingredients_text, which would set ingredients_text_changed?
    # to true (it was previously nil). Ensure that we don't process this.
    if ingredients_text_changed? && !ingredients_text.blank?
      # manual ingredient entry. parse it out into Ingredient objects
      add_ingredients_from_self
    end
  end

end

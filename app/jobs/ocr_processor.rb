# OCR processing!

require 'open-uri'
require 'tempfile'

class OCRProcessor
  @queue = :ocr_processing

  def self.perform(recipe_id)
    recipe = Recipe.find(recipe_id)
    if !recipe.nil?

      # OCRSDK::Image.new expects a local file path as a string,
      # so we have to create a local file to work with the image

      document_url = recipe.document.to_s
      extension = File.extname(document_url)
      basename = File.basename(document_url, extension)
      file = Tempfile.new([basename, extension])
      file.binmode
      open(recipe.document.url) { |data| file.write data.read }

      # Send the local file for processing
      image = OCRSDK::Image.new(file.path)
      txt = image.as_text_sync([:english])

      # Update the model
      recipe.ocr_raw_text = txt
      recipe.source = "Created from #{recipe.document.sanitized_file.filename}"
      recipe.ocr_processed = true

      recipe.save!
    end
  end

end
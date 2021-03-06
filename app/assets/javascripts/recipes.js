// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( function () {
  var fileInput = $('#file-input');
  var fileButton = $('#file-button');
  var fileName = $('#file-name');

  fileInput.hide();

  var handleFile = function (fileElement) {
    var file = fileElement.files[0];
    var name = file.name;
    var size = parseInt(file.size, 10);
    var sizeString = size.toString() + " bytes";
    if (size >= 1000 && size < 1000000) {
      sizeString = (Math.floor(size/1000)).toString() + " kb";
    }
    else if (size >= 1000000) {
      sizeString = (Math.floor(size/1000000)).toString() + " Mb";
    }

    fileName.text(name + " (" + sizeString + ")");
    fileButton.text("Choose a different photo");
  };

  fileInput.on('change', function () {
    handleFile(this);
  });

  fileButton.on('click', function (e) {
    e.preventDefault();
    // fakes a click, brings up the dialog box to select a file
    fileInput.click();
  });



  var updateRecipe = function (textAreaEl) {
    var recipeID = $('.recipe-container').attr('data-id');
    var infoBox = $('.recipe-container .info-box');
    var rawText = textAreaEl.val();
    $.ajax({
      url: "/recipes/" + recipeID,
      method: "put",
      data: { "recipe": { "ocr_raw_text": rawText }},
      dataType: "json",
      success: function (recipe) {
        infoBox.slideDown(300);
        infoBox.text("Recipe updated!");
        setTimeout(function () { infoBox.slideUp(500); infoBox.text(""); }, 1000);
      },
      error: function (e) {
        infoBox.text("Your recipe did not save.");
      }
    });
  };

  /* save recipe every 10 seconds anyway */
  // setInterval(function () { updateRecipe($('#ocr-raw-text')); }, 10000);

  /* save ocr raw text on change */
  $('#ocr-raw-text').on('change', function (event) {
    event.preventDefault();
    updateRecipe($(this));
  });

});
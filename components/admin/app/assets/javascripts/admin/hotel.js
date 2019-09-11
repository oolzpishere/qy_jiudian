
$(document).on("ready page:load turbolinks:load", function() {
  // #hotel form
  // set tax_rate default value
  if ($('#hotel_tax_rate').length > 0 && $('#hotel_tax_rate').val().length == 0) {
    $('#hotel_tax_rate').val("0.15")
  }
});

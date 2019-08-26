
$(document).on("ready page:load turbolinks:load", function() {
  if ($('#send_sms').length > 0) {
    $('#send_sms').on('click',function(){
      getAllChecked();

    });

    function getAllChecked() {
      var selectedItems = [];
      $("input[name='select']").each(function(){
        if (this.checked) {
          selectedItems.push(this);
        }
      })
      return selectedItems;
    };
  }

  if ($('#order_form').length > 0) {
    $('.has_many_field_li:first input:first').attr('required', 'required');
    $('#order_form').validate();
  }

});


$(document).on("ready page:load turbolinks:load", function() {
  // #index
  if ($('#send_sms').length > 0) {
    $('#send_sms').on('click',function(){
      getAllChecked();

    });

    $(document).on('click','#render_xlsx',function(e){
      e.preventDefault();
      var allChecked = getAllChecked(),
        conference_and_hotel = get_conference_and_hotel_by_path(),
        conference_id = conference_and_hotel['conference'],
        hotel_id = conference_and_hotel['hotel'],
        url = "/admin/orders/download.xlsx?conference_id=" + conference_id + "&hotel_id=" + hotel_id;

      var $preparingFileModal = $("#preparing-file-modal");
      $preparingFileModal.dialog({ modal: true });

      $.fileDownload(url, {
        httpMethod: "POST",
        data: {orders: JSON.stringify(allChecked)},
        successCallback: function (url) {
            $preparingFileModal.dialog('close');
        },
        failCallback: function (responseHtml, url) {
            $preparingFileModal.dialog('close');
            $("#error-modal").dialog({ modal: true });
        }
      })

      return false; //this is critical to stop the click event which will trigger a normal file download!

    });

    // select_all logic
    $('#select_all').on('click',function(){
      if (this.checked) {
        $("input[name='select']").each(function(){
          this.checked = true;
        });
      } else {
        $("input[name='select']").each(function(){
          this.checked = false;
        });
      }
    });

    function get_conference_and_hotel_by_path(){
      var current_path = window.location.pathname,
        regex = /conferences\/(\d)\/hotels\/(\d)/,
        regex_result = regex.exec(window.location.pathname),
        conference_id = regex_result[1],
        hotel_id = regex_result[2]

      return {conference: conference_id, hotel: hotel_id}
    }

    function getAllChecked() {
      var selectedItems = [];
      $("input[name='select']").each(function(){
        if (this.checked) {
          selectedItems.push(this.value);
        }
      })
      return selectedItems;
    };
  }

  // #form
  // jquery form validation.
  if ($('#order_form').length > 0) {
    $('.has_many_field_li:first input:first').attr('required', 'required');
    $('#order_form').validate();
  }



});

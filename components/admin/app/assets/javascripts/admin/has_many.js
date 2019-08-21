
$(document).on("ready page:load turbolinks:load", function() {
  function addMore(groupId) {
    var newfield = $(groupId).children("li").last().clone();
    var newid = Number(newfield.children("input").attr('id').match(/attributes_(\d+)_/)[1]) + 1;
    // var newname = Number(newfield.attr('id').replace(/_(\d+)_/, "$1")) + 1;

    // newdiv.attr('id', "post_relics_attributes_" + newid)

    $.each(newfield.find("input[type='text']"), function() {
       var thisid = $(this).attr('id'),
       thisname = $(this).attr('name');

       thisid = thisid.replace(/\d+/, newid);
       thisname = thisname.replace(/\d+/, newid);

       $(this).attr('name', thisname);
       $(this).attr('id', thisid);
       var val = $(this).val();
       if (val == "0" || val == "1" ) {
         $(this).val('0');
       } else {
         $(this).val('');
       }

    });

    $.each(newfield.find("label"), function() {
       var thisname = $(this).attr('for');
       thisname = thisname.replace(/\d/, newid);

       $(this).attr('for', thisname);
     });

    $(groupId).append(newfield);
  }

  $('#has-many-addmore').on('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    addMore("#rooms_ul")
  });

  $('#hotel_conference_selection').selectize();

  var xhr;
  var order_conference_selection, $order_conference_selection;
  var order_hotel_selection, $order_hotel_selection;

  $order_conference_selection = $('#order_conference_selection').selectize({
    onChange: function(value) {
      if (!value.length) return;
      order_hotel_selection.disable();
      order_hotel_selection.clear();
      order_hotel_selection.clearOptions();
      order_hotel_selection.load(function(callback) {
        xhr && xhr.abort();
        xhr = $.ajax({
            url: '/admin/conferences/' + value + '/hotels.json',
            success: function(results) {
                order_hotel_selection.enable();
                callback(results);
            },
            error: function() {
                callback();
            }
        })
      });
    }
  });

  $order_hotel_selection = $('#order_hotel_selection').selectize({
    valueField: 'id',
    labelField: 'name',
    searchField: ['name']
  });

  order_conference_selection  = $order_conference_selection[0].selectize;

  order_hotel_selection = $order_hotel_selection[0].selectize;

});

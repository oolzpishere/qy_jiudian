
$(document).on("ready page:load turbolinks:load", function() {

  $('#hotel_conference_selection').selectize();

  var xhr;
  var order_conference_selection, $order_conference_selection;
  var order_hotel_selection, $order_hotel_selection;
  var room_type_selection, $room_type_selection
  var hotel_hash, room_type_selected;
  var existingRoomTypeOptions;

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
    searchField: ['name'],
    // get hotel_hash
    onInitialize: function(){
      if (this.items.length) {
        var init_hotel_id = this.items[0];
        $.ajax({
          url: '/admin/hotels/' + init_hotel_id + '.json',
          success: function(results) {
            hotel_hash = results;
          },
          error: function() {
          }
        });
      }
    },
    // get hotel_hash
    onChange: function(value) {
      if (!value.length) return;
      $.ajax({
        url: '/admin/hotels/' + value + '.json',
        success: function(results) {
          hotel_hash = results;
          // refresh hotel_hash first!
          resetRoomTypeOptions();
          resetAllHotelField();
        },
        error: function() {
        }
      })

    }
  });

  $room_type_selection = $('#room_type_selection').selectize({
    valueField: 'db_name',
    labelField: 'name',
    searchField: ['name'],
    onInitialize: function(){
      if (this.items.length) {
        room_type_selected = this.items[0];
      }
    },
    onChange: function(value) {
      if (!value.length) return;
      room_type_selected = value;
      resetAllHotelField();

    }
  });

  if ($order_conference_selection.length) {
    order_conference_selection  = $order_conference_selection[0].selectize;
  }
  if ($order_hotel_selection.length) {
    order_hotel_selection = $order_hotel_selection[0].selectize;
  }
  if ($room_type_selection.length) {
    room_type_selection = $room_type_selection[0].selectize;
  }


  function resetAllHotelField(){
    var price_db_name = room_type_selected + '_price';
    if (hotel_hash) {
      var hotel_price = hotel_hash[price_db_name]
      $('#order_price').val(hotel_price)
    }

  }

  var room_types_array = ["twin_beds", "queen_bed", "three_beds","other_twin_beds"];
  var roomTypeTranslate = {"twin_beds": "双人房","queen_bed": "大床房", "three_beds": "三人房","other_twin_beds": "其它双人房" };
  function resetRoomTypeOptions(){
    room_type_selection.clear();
    room_type_selection.clearOptions();

    var existingRoomTypeArray = [];
    existingRoomTypeOptions = [];
    room_types_array.forEach(function(element) {
      if (hotel_hash && hotel_hash[element] > 0 ) {
        existingRoomTypeArray.push(element);
      }
    });

    existingRoomTypeArray.forEach(function(element){
      var hash = {"db_name": element, "name": roomTypeTranslate[element]};
        existingRoomTypeOptions.push(hash);
    });

    room_type_selection.load(function(callback) {
      callback(existingRoomTypeOptions)
    });
  }

});

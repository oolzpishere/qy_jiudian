module Admin
  class DateRoomsCheck
    # attr_reader
    def initialize( order: )
      @order = order
      @hotel_room_type = get_hotel_room_type(order)

      # before data
      @order_rooms_before = @order.rooms.length
      before_checkin = @order.checkin
      before_checkout = @order.checkout
      @before_date_range_array = (before_checkin..before_checkout).to_a
      @before_date_range_array.pop
    end

    # have check after assign attributes to @order, because order_rooms_change_to need assigned @order.
    def check_all_date_rooms
      return false unless hotel_room_type

      date_range_array_now.each do |date|

        restore_status = DateRoomsStatus.new(order: @order).restore_status
        rooms_left = restore_status[hotel_room_type][date.to_s]
        # check date
        return false unless rooms_left
        # check rooms
        return false unless ( rooms_left - date_room(hotel_room_type, date).rooms ) >= 0
      end
      return true
    end

    # get current date_range_array, track the newest checkin and checkout.
    def date_range_array_now
      date_range_array = (@order.checkin..@order.checkout).to_a
      date_range_array.pop
      date_range_array
    end

    def get_hotel_room_type(order)
      # hotel and room_types have to be compound keys.
      Product::HotelRoomType.joins(:room_type).where(hotel: order.hotel, room_types: {name_eng: order.room_type}).first
    end

    def date_room(hotel_room_type, date)
      hotel_room_type.date_rooms.select { |dr| dr.date == date }.first
    end

  end


end

module Admin
  class DateRoomsStatus
    attr_accessor :before_status_hash
    attr_reader :order, :order_before
    def initialize( order: nil, order_before: nil)
      @order = order
      @order_before = order_before
      @before_status_hash = {}
    end

    def restore_status
      self.set_before_status
      before_status_hash
      order_rooms_num = order_before.rooms.length
      order_before.hotel.hotel_room_types.each do |hrt|
        room_type_name = hrt.room_type.name_eng
        hrt.date_rooms.each do |dr|
          before_status_hash[room_type_name][dr.date.to_s] += order_rooms_num
        end
      end
      before_status_hash
    end

    def set_before_status
      raise "order_before not set" unless order_before
      order_before.hotel.hotel_room_types.each do |hrt|
        room_type_name = hrt.room_type.name_eng
        hash[ room_type_name ] = {}
        hrt.date_rooms.each do |dr|
          before_status_hash[ room_type_name ][dr.date.to_s] = dr.rooms
        end
      end
    end


  end

end

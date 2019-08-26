module Admin
  class OrderData
    # attr_accessor :twin_beds, :queen_bed, :three_beds, :other_twin_beds
    attr_reader :order, :i, :room
    def initialize(params)
      @order = params[:order]
      @i = params[:i]
      @room = params[:room]
      @room_types_array = ["twin_beds", "queen_bed", "three_beds","other_twin_beds"]
    end

    def send_command(command)
      if order.try(command)
        order.send(command)
      else
        self.send(command)
      end
    end

    def id
      i + 1
    end

    def names
      room.names
    end

    def room_number
      room.room_number
    end

    def twin_beds
      order.room_type.match(/twin_beds/) ? 1 : ""
    end

    def queen_bed
      order.room_type.match(/queen_bed/) ? 1 : ""
    end

    def three_beds
      order.room_type.match(/three_beds/) ? 1 : ""
    end

    def other_twin_beds
      order.room_type.match(/other_twin_beds/) ? 1 : ""
    end

    def twin_beds_price
      order.room_type.match(/twin_beds/) ? order.hotel.twin_beds_price : ""
    end

    def queen_bed_price
      order.room_type.match(/queen_bed/) ? order.hotel.queen_bed_price : ""
    end

    def three_beds_price
      order.room_type.match(/three_beds/) ? order.hotel.three_beds_price : ""
    end

    def other_twin_beds_price
      order.room_type.match(/other_twin_beds/) ? order.hotel.other_twin_beds_price : ""
    end

    def check_in_out
      order.checkin
    end

    def nights
      order.nights
    end

    def breakfast
      order.breakfast
    end


  end
end

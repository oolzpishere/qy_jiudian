module Admin
  class OrderData
    # attr_accessor :twin_beds, :queen_bed, :three_beds, :other_twin_beds
    attr_reader :order, :i, :room, :room_type_translate
    def initialize(params)
      @order = params[:order]
      @i = params[:i]
      @room = params[:room]
      @room_types_array = ["twin_beds", "queen_bed", "three_beds","other_twin_beds"]
      @room_type_translate = {"twin_beds" => "双人房","queen_bed" => "大床房", "three_beds" => "三人房","other_twin_beds" => "其它双人房" }
    end

    def send_command(command)
      if self.try(command)
        self.send(command)
      elsif order.try(command)
        order.send(command)
      end
    end

    def conference_name
      order.conference.name
    end

    def hotel_name
      order.hotel.name
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
      checkin = order.checkin
      checkout = order.checkout
      "#{checkin.month}月#{checkin.day}日-#{checkout.month}月#{checkout.day}日"
    end

    def conference_check_in_out
      checkin = order.conference.sale_from
      checkout = order.conference.sale_to
      "#{checkin.month}月#{checkin.day}日-#{checkout.month}月#{checkout.day}日"
    end

    def nights
      (order.checkout-order.checkin).to_i
    end

    def breakfast
      order.breakfast.to_i == 1 ? "含早" : "不含早"
    end

    def breakfast_boolean
      order.breakfast.to_i == 1 ? "含" : "不含"
    end

    def all_names
      names = []
      order.rooms.each do |room|
        names += room.names.split(/,|、|，/)
      end
      names
    end

    def all_names_string
      all_names.join('、')
    end

    def peoples_count
      "#{all_names.count}人"
    end

    def room_type_zh
      room_type_translate[order.room_type]
    end

    def room_count_zh
      "#{order.rooms.count}间"
    end

    def price
      order.hotel.send(order.room_type + "_price")
    end

    def price_zh
      "#{price}元/间/天"
    end

    def total_price
      # 单价 * 天数
      price * nights
    end

    def car
      order.hotel.car == 0 ? "不含用车" : "含用车"
    end

  end
end

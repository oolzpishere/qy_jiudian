require_dependency "admin/application_controller"

module Admin
  class Manager::OrdersController < Manager::ApplicationController
    protect_from_forgery except: :download
    # skip_before_action :authenticate_admin!, :only => [:download]

    before_action :set_order, only: [:show, :edit, :update, :destroy]

    # for nested resources
    before_action :set_conference, only: [:index, :new, :create, :edit, :download, :send_sms]
    before_action :set_hotel, only: [:index, :new, :create, :edit, :download, :send_sms]
    before_action :set_room_types_array, only: [:index, :new, :create, :edit, :download]
    before_action :hotel_room_types, only: [:index, :new, :create, :edit]
    before_action :set_show_attributes, only: [:show]

    # GET /orders
    def index
      @orders = Product::Order.where(conference: @conference, hotel: @hotel)
    end

    # GET /orders/1
    def show
    end

    # GET /orders/new
    def new
      @order = Product::Order.new
      1.times { @order.rooms.build }
    end

    # GET /orders/1/edit
    def edit
      1.times { @order.rooms.build } if @order.rooms.empty?
    end

    # POST /orders
    def create
      @order = Product::Order.new(order_params)

      checkin = @order.checkin
      checkout = @order.checkout
      order_rooms_change = @order.rooms.length

      unless change_room_num(@order, checkin, checkout, order_rooms_change)
        redirect_to(admin.conference_hotel_orders_path(@conference, @hotel), notice: '入住日期不在售卖范围内，请重新填写，或修改酒店售卖日期')
      end

      if @order.save

        ::Admin::SendSms::Ali.new(@order, "order").send_sms
        redirect_to(admin.conference_hotel_orders_path(@conference, @hotel), notice: 'Order was successfully created.')
      else
        render :new
      end
    end

    # PATCH/PUT /orders/1
    def update
      order_rooms_org = @order.rooms.length

      if @order.update(order_params)
        checkin = @order.checkin
        checkout = @order.checkout
        order_rooms_change = @order.rooms.length - order_rooms_org

        unless change_room_num(@order, checkin, checkout, order_rooms_change)
          return redirect_back_or_default(admin.admin_root_path, notice: '入住日期不在售卖范围内，请重新填写，或修改酒店售卖日期')
        end

        redirect_back_or_default(admin.admin_root_path, notice: 'Order was successfully updated.')
      else
        render :edit
      end
    end

    # DELETE /orders/1
    def destroy
      @order.destroy
      checkin = @order.checkin
      checkout = @order.checkout
      order_rooms_change = -@order.rooms.length

      change_room_num(@order, checkin, checkout, order_rooms_change)

      ::Admin::SendSms::Ali.new(@order, "cancel").send_sms
      redirect_back(fallback_location: admin.admin_root_path,notice: 'Order was successfully destroyed.')
    end

    def download
      cookies['fileDownload'] = 'true'

      # @orders = Product::Order.all
      orders_string = params[:orders]
      orders_array = JSON.parse(orders_string)
      @orders = Product::Order.order(:id).find(orders_array)

      respond_to do |format|
         format.xlsx {
           render xlsx: 'download.xlsx.axlsx', layout: false, filename: "#{@conference.name}_#{@hotel.name}_#{Time.now}.xlsx"
           # response.headers['Content-Disposition'] = 'attachment; filename="my_new_filename.xlsx"'
         }
      end
    end

    def send_sms
      orders_string = params[:orders]
      orders_array = JSON.parse(orders_string)
      @orders = Product::Order.order(:id).find(orders_array)

      @orders.each {|order| ::Admin::SendSms::Ali.new(order, "order").send_sms }
      # ::Admin::SendSms::Ali.new(@orders, "SMS_173472652").send_sms
    end

    private

      def set_conference
        if params[:conference_id]
          # for new
          @conference = Product::Conference.find(params[:conference_id])
        else
          # for edit
          @conference = @order.conference
        end

      end

      def set_hotel
        if params[:conference_id]
          # for new
          @hotel = Product::Hotel.find(params[:hotel_id])
        else
          # for edit
          @hotel = @order.hotel
        end

      end

      def set_room_types_array
        @room_types_array = ["twin_beds", "queen_bed", "three_beds","other_twin_beds"]
        @room_type_translate = {"twin_beds" => "双人房","queen_bed" => "大床房", "three_beds" => "三人房","other_twin_beds" => "其它双人房" }
      end

      def hotel_room_types
        # true_room_types_array = @room_types_array.select {|name| @hotel[name] && @hotel[name] > 0}
        @room_type_options = []
        @hotel.room_types.each {|room_type| @room_type_options << [ room_type['name'], room_type['name_eng'] ]}

        # true_room_types_array.each {|name| @room_type_options << [@room_type_translate[name], name ]}
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_order
        @order = Product::Order.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def order_params
        params.fetch(:order, {}).permit(
          :id,
          :group,
          :count,
          :conference_id,
          :hotel_id,
          :room_type,
          :names,
          :contact,
          :phone,
          :price,
          :breakfast,
          :checkin,
          :checkout,
          :nights,
          :total_price,
          rooms_attributes: [:id, :names, :room_number, :_destroy],
        )
      end

      # copy from permit.
      # at most 4 columns
      def set_show_page_attributes
        @show_page_attributes = [:group, :names, :contact, :phone]
      end

      def set_show_attributes
        @show_attributes = [ :group, :conference_name, :hotel_name, :room_type_zh, :room_count_zh, :all_names_string, :contact, :phone, :price, :breakfast, :car, :checkin, :checkout, :nights]
      end

      def set_attribute_types
        # @attribute_types = {
        #   # id: "Field::String",
        #   group: "Field::Number",
        #   # count: "Field::Number",
        #   rooms: {field_type: "Field::HasMany", show: ["names", "room_number"]},
        #   # names: "Field::String",
        #   contact: "Field::String",
        #   phone: "Field::String",
        #   price: "Field::Number",
        #   breakfast: "Field::Number",
        #   checkin: "Field::DateTime",
        #   checkout: "Field::DateTime",
        #   nights: "Field::Number",
        #   total_price: "Field::Number",
        # }
      end

      def change_room_num(order, checkin, checkout, order_rooms_change)
        date_range_array = (checkin.strftime("%Y%m%d")..checkout.strftime("%Y%m%d")).to_a
        date_range_array.pop
        hotel_room_type = get_hotel_room_type(order)

        date_range_array.each do |date|
          date_room = hotel_room_type.date_rooms.find_by(date: date)
          unless date_room
            return false
          end
          date_room.rooms = date_room.rooms - order_rooms_change
          date_room.save
        end
      end

      def get_hotel_room_type(order)
        room_type_id = order.hotel.room_types.find_by(name_eng: order.room_type).id
        order.hotel.hotel_room_types.find_by(room_type_id: room_type_id)
      end


  end
end

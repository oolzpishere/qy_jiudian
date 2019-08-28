require_dependency "admin/application_controller"

module Admin
  class Admin::OrdersController < Admin::ApplicationController
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
      @orders = Product::Order.all
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

      if @order.save
        orders_send_sms([@order], 406860)
        # @order.rooms_attributes.save
        redirect_to(admin.conference_hotel_orders_path(@conference, @hotel), notice: 'Order was successfully created.')
      else
        render :new
      end
    end

    # PATCH/PUT /orders/1
    def update
      if @order.update(order_params)
        redirect_back_or_default(admin.admin_root_path, notice: 'Order was successfully updated.')
      else
        render :edit
      end
    end

    # DELETE /orders/1
    def destroy
      @order.destroy
      orders_send_sms([@order], 406872)
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

      order_send_sms(@orders, 406860)
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
        true_room_types_array = @room_types_array.select {|name| @hotel[name] && @hotel[name] > 0}
        @room_type_options = []
        true_room_types_array.each {|name| @room_type_options << [@room_type_translate[name], name ]}
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
        @show_attributes = [ :group, :conference_name, :hotel_name, :room_type_zh, :room_count_zh, :all_names_string, :contact, :phone, :price, :breakfast, :checkin, :checkout, :nights]
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

      def orders_send_sms(orders, template_code)
        orders.each do |order|
          order_data = ::Admin::OrderData.new(order: order)
          phone_number = order.phone
          params = [
            order.conference.name,
            order.hotel.name,
            "#{order_data.check_in_out}#{order_data.nights}天",
            order_data.all_names_string,
            order_data.peoples_count,
            order_data.room_type_zh + order_data.room_count_zh,
            order_data.price_zh,
            "#{order_data.breakfast}"
          ]
          Qcloud::Sms.single_sender(phone_number, template_code, params)
        end
      end

  end
end

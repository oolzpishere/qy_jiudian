require_dependency "admin/application_controller"

module Admin
  class Admin::OrdersController < Admin::ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    # for nested resources
    before_action :set_conference, only: [:index, :new, :create, :edit]
    before_action :set_hotel, only: [:index, :new, :create, :edit]

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
      redirect_back(fallback_location: admin.admin_root_path,notice: 'Order was successfully destroyed.')
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
        set_room_types_array
      end

      def set_room_types_array
        room_types_array = ["twin_beds", "queen_bed", "three_beds","other_twin_beds"]
        room_type_translate = {"twin_beds" => "双人房","queen_bed" => "大床房", "three_beds" => "三人房","other_twin_beds" => "其它双人房" }
        true_room_types_array = room_types_array.select {|name| @hotel[name] && @hotel[name] > 0}
        @room_type_options = []
        true_room_types_array.each {|name| @room_type_options << [room_type_translate[name], name ]}
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
        @show_page_attributes = [
          :group,
          :names,
        ]
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

  end
end

require_dependency "admin/application_controller"

module Admin
  class Admin::OrdersController < Admin::ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

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
    end

    # POST /orders
    def create
      @order = Product::Order.new(order_params)

      if @order.save
        # @order.rooms_attributes.save
        redirect_to @order, notice: 'Order was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /orders/1
    def update
      if @order.update(order_params)
        redirect_to @order, notice: 'Order was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /orders/1
    def destroy
      @order.destroy
      redirect_to orders_url, notice: 'Order was successfully destroyed.'
    end

    private
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
          :names,
          :contact,
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
        @attribute_types = {
          # id: "Field::String",
          group: "Field::Number",
          # count: "Field::Number",
          rooms: {field_type: "Field::HasMany", show: ["names", "room_number"]},
          # names: "Field::String",
          contact: "Field::String",
          price: "Field::Number",
          breakfast: "Field::Number",
          checkin: "Field::DateTime",
          checkout: "Field::DateTime",
          nights: "Field::Number",
          total_price: "Field::Number",
        }
      end

  end
end

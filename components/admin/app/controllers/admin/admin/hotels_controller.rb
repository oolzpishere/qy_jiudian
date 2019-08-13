require_dependency "admin/application_controller"

module Admin
  class Admin::HotelsController < Admin::ApplicationController
    before_action :set_admin_hotel, only: [:show, :edit, :update, :destroy]

    # GET /admin/hotels
    def index
      @hotels = Product::Hotel.all
    end

    # GET /admin/hotels/1
    def show
    end

    # GET /admin/hotels/new
    def new
      @hotel = Product::Hotel.new
    end

    # GET /admin/hotels/1/edit
    def edit
    end

    # POST /admin/hotels
    def create
      @hotel = Product::Hotel.new(hotel_params)

      if @hotel.save
        redirect_to @hotel, notice: 'Hotel was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /admin/hotels/1
    def update
      if @hotel.update(hotel_params)
        redirect_to @hotel, notice: 'Hotel was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin/hotels/1
    def destroy
      @hotel.destroy
      redirect_to admin_hotels_url, notice: 'Hotel was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_admin_hotel
        @hotel = Product::Hotel.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def hotel_params
        params.fetch(:hotel, {}).permit(
          :name,
          :twin_beds,
          :queen_bed,
          :three_beds,
          :other_twin_beds,
          :twin_and_queen_price,
          :three_beds_price,
          :other_twin_beds_price,
          :breakfast,
        )
      end

      # copy from permit.
      # at most 4 columns
      def set_show_page_attributes
        @show_page_attributes = [
          :id,
          :name,
        ]
      end

      def set_attribute_types
        @attribute_types = {
          # id: "Field::String",
          name: "Field::String",
          twin_beds: "Field::Number",
          queen_bed: "Field::Number",
          three_beds: "Field::Number",
          other_twin_beds: "Field::Number",
          twin_and_queen_price: "Field::Number",
          three_beds_price: "Field::Number",
          other_twin_beds_price: "Field::Number",
          breakfast: "Field::Number",
        }
      end
  end
end

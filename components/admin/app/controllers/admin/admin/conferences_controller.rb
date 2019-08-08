require_dependency "admin/application_controller"

module Admin
  class Admin::ConferencesController < Admin::ApplicationController
    before_action :set_conference, only: [:show, :edit, :update, :destroy]

    # GET /conferences
    def index
      @conferences = Product::Conference.all
    end

    # GET /conferences/1
    def show
    end

    # GET /conferences/new
    def new
      @conference = Product::Conference.new
    end

    # GET /conferences/1/edit
    def edit
    end

    # POST /conferences
    def create
      @conference = Product::Conference.new(conference_params)

      if @conference.save
        redirect_to @conference, notice: 'Conference was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /conferences/1
    def update
      if @conference.update(conference_params)
        redirect_to @conference, notice: 'Conference was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /conferences/1
    def destroy
      @conference.destroy
      redirect_to conferences_url, notice: 'Conference was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_conference
        @conference = Product::Conference.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def conference_params
        params.fetch(:conference, {})
      end
  end
end

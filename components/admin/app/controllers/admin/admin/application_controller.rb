module Admin
  class Admin::ApplicationController < ApplicationController

    before_action :authenticate_admin!
    # before_action :check_user
    before_action :get_conferences


    private
      def get_conferences
        @conferences = Product::Conference.all
      end

  end
end

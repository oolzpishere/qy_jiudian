module Admin
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :authenticate_admin!

    # before_action :check_user

    private
    def check_user
      if current_admin
        flash.clear
        # if you have rails_admin. You can redirect anywhere really
        # redirect_to(rails_admin.dashboard_path) && return
      elsif current_user
        flash.clear
        # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
        # redirect_to(authenticated_user_root_path) && return
      end
    end

  end
end

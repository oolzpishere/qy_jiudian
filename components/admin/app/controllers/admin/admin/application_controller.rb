module Admin
  class Admin::ApplicationController < ApplicationController

    before_action :authenticate_admin!
    # before_action :check_user

  end
end

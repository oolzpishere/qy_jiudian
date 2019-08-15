require 'rails_helper'

RSpec.describe Admin::Admin::OrdersController, type: :controller do
  routes { Admin::Engine.routes }

  describe "" do
    login_admin

    it "" do
      get :index
      expect(response).to have_http_status(200)
    end

  end

end

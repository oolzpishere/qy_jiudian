require 'rails_helper'

RSpec.describe Admin::Manager::OrdersController, type: :controller do
  routes { Admin::Engine.routes }

  describe "Authorise manager" do
    login_manager

    before(:each) do
      FactoryBot.create(:conf)
    end

    let(:conf) { Product::Conference.find("1") }
    
    # it "" do
    #   get :index
    #   expect(response).to have_http_status(200)
    # end

  end

end

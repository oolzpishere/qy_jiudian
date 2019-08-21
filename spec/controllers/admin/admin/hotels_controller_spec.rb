require 'rails_helper'

RSpec.describe Admin::Admin::HotelsController, type: :controller do
  routes { Admin::Engine.routes }
  let(:valid_attributes) {
    {
      id: 1,
      name: "hotel-name",
      conference_ids: ["1"],
      twin_beds: "25",
      queen_bed: "20",
      three_beds: "15",
      other_twin_beds: "10",
      twin_and_queen_price: "250",
      three_beds_price: "150",
      other_twin_beds_price: "100",
      breakfast: "0",
    }
  }

  let(:new_attributes) {
    {
      id: 1,
      name: "hotel-name-new",
      twin_beds: "25",
      queen_bed: "20",
      three_beds: "15",
      other_twin_beds: "10",
      twin_and_queen_price: "250",
      three_beds_price: "150",
      other_twin_beds_price: "100",
      breakfast: "0",
    }
  }

  let(:valid_session) { {} }

  describe "Authorise admin" do
    login_admin

    before(:each) do
      FactoryBot.create(:conf)
    end

    let(:conf) { Product::Conference.find("1") }

    describe "GET #index" do
      it "returns a success response" do
        hotel = Product::Hotel.create! valid_attributes
        get :index, params: {conference_id: conf.id}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        hotel = Product::Hotel.create! valid_attributes
        get :show, params: {id: hotel.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #new" do
      it "returns a success response" do
        get :new, params: {conference_id: conf.id}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #edit" do
      it "returns a success response" do
        hotel = Product::Hotel.create! valid_attributes
        get :edit, params: {id: hotel.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new item" do
          expect {
            post :create, params: {conference_id: conf.id, hotel: valid_attributes}
          }.to change(Product::Hotel, :count).by(1)
        end
      end

    end

    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested item" do
          hotel = Product::Hotel.create! valid_attributes
          hotel_org = hotel.dup
          put :update, params: {conference_id: conf.id, id: hotel.to_param, hotel: new_attributes}, session: valid_session
          hotel.reload
          expect(hotel_org).to_not eq(hotel)
        end
      end

    end

    describe "DELETE #destroy" do
      it "destroys the requested item" do
        hotel = Product::Hotel.create! valid_attributes
        expect {
          delete :destroy, params: {id: hotel.to_param}, session: valid_session
        }.to change(Product::Hotel, :count).by(-1)
      end
    end
  end

end

require 'test_helper'

module Admin
  class Admin::HotelsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @admin_hotel = admin_admin_hotels(:one)
    end

    test "should get index" do
      get admin_hotels_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_hotel_url
      assert_response :success
    end

    test "should create admin_hotel" do
      assert_difference('Admin::Hotel.count') do
        post admin_hotels_url, params: { admin_hotel: {  } }
      end

      assert_redirected_to admin_hotel_url(Admin::Hotel.last)
    end

    test "should show admin_hotel" do
      get admin_hotel_url(@admin_hotel)
      assert_response :success
    end

    test "should get edit" do
      get edit_admin_hotel_url(@admin_hotel)
      assert_response :success
    end

    test "should update admin_hotel" do
      patch admin_hotel_url(@admin_hotel), params: { admin_hotel: {  } }
      assert_redirected_to admin_hotel_url(@admin_hotel)
    end

    test "should destroy admin_hotel" do
      assert_difference('Admin::Hotel.count', -1) do
        delete admin_hotel_url(@admin_hotel)
      end

      assert_redirected_to admin_hotels_url
    end
  end
end

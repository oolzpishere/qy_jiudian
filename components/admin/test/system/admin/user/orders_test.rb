require "application_system_test_case"

module Admin
  class User::OrdersTest < ApplicationSystemTestCase
    setup do
      @user_order = admin_user_orders(:one)
    end

    test "visiting the index" do
      visit user_orders_url
      assert_selector "h1", text: "User/Orders"
    end

    test "creating a Order" do
      visit user_orders_url
      click_on "New User/Order"

      click_on "Create Order"

      assert_text "Order was successfully created"
      click_on "Back"
    end

    test "updating a Order" do
      visit user_orders_url
      click_on "Edit", match: :first

      click_on "Update Order"

      assert_text "Order was successfully updated"
      click_on "Back"
    end

    test "destroying a Order" do
      visit user_orders_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Order was successfully destroyed"
    end
  end
end

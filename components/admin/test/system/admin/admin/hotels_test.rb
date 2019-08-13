require "application_system_test_case"

module Admin
  class Admin::HotelsTest < ApplicationSystemTestCase
    setup do
      @admin_hotel = admin_admin_hotels(:one)
    end

    test "visiting the index" do
      visit admin_hotels_url
      assert_selector "h1", text: "Admin/Hotels"
    end

    test "creating a Hotel" do
      visit admin_hotels_url
      click_on "New Admin/Hotel"

      click_on "Create Hotel"

      assert_text "Hotel was successfully created"
      click_on "Back"
    end

    test "updating a Hotel" do
      visit admin_hotels_url
      click_on "Edit", match: :first

      click_on "Update Hotel"

      assert_text "Hotel was successfully updated"
      click_on "Back"
    end

    test "destroying a Hotel" do
      visit admin_hotels_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Hotel was successfully destroyed"
    end
  end
end

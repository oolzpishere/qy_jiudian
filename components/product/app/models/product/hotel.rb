module Product
  class Hotel < ApplicationRecord
    self.table_name = :hotels

    has_many :conference_hotels
    has_many :conferences, through: :conference_hotels
    # accepts_nested_attributes_for :conferences, reject_if: :all_blank
    has_many :room_type_prices
    has_many :room_types, through: :room_type_prices
    accepts_nested_attributes_for :room_type_prices, reject_if: :all_blank, allow_destroy: true
  end
end

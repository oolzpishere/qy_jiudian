module Product
  class Order < ApplicationRecord
    self.table_name = :orders

    has_many :rooms
    accepts_nested_attributes_for :rooms, allow_destroy: true, reject_if: :all_blank
  end
end

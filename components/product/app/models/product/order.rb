module Product
  class Order < ApplicationRecord
    self.table_name = :orders

    belongs_to :conference
    belongs_to :hotel

    has_many :rooms
    accepts_nested_attributes_for :rooms, allow_destroy: true, reject_if: :all_blank
  end
end

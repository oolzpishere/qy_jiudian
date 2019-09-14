module Product
  class DateRoom < ApplicationRecord
    self.table_name = :date_rooms

    belongs_to :room_type_price
  end
end

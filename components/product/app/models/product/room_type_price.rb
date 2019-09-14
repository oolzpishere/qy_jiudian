module Product
  class RoomTypePrice < ApplicationRecord
    self.table_name = :room_type_prices

    belongs_to :hotel
    belongs_to :room_type
  end
end

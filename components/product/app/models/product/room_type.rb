module Product
  class RoomType < ApplicationRecord
    self.table_name = :room_types

    has_many :room_type_prices
    has_many :hotels, through: :room_type_prices

    # Product::RoomType.create(name: "标双", name_eng: "twin_beds")
    # Product::RoomType.create(name: "标单", name_eng: "queen_bed")
    # Product::RoomType.create(name: "三人间", name_eng: "three_beds")
    # Product::RoomType.create(name: "其它双人间", name_eng: "other_twin_beds")
  end
end

class CreateRoomTypePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :room_type_prices do |t|
      t.belongs_to :hotel, index: true
      t.belongs_to :room_type, index: true
      t.decimal :price
      t.decimal :settlement_price

      t.timestamps
    end
  end
end

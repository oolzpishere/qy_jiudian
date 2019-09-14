class CreateDateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :date_rooms do |t|
      t.belongs_to :room_type_price, index: true
      t.date :date
      t.integer :rooms

      t.timestamps
    end
  end
end

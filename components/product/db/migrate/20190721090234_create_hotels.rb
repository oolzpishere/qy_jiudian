class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name, null: false
      t.integer :twin_beds
      t.integer :queen_bed
      t.integer :three_beds
      t.integer :other_twin_beds
      t.integer :twin_and_queen_price
      t.integer :three_beds_price
      t.integer :other_twin_beds_price
      t.integer :breakfast, default: 0

      t.timestamps
    end
  end
end

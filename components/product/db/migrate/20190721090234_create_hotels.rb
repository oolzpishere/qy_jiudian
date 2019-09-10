class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name, null: false
      t.integer :twin_beds
      t.integer :queen_bed
      t.integer :three_beds
      t.integer :other_twin_beds
      t.decimal :twin_beds_price
      t.decimal :queen_bed_price
      t.decimal :three_beds_price
      t.decimal :other_twin_beds_price
      t.decimal :twin_beds_settlement_price
      t.decimal :queen_bed_settlement_price
      t.decimal :three_beds_settlement_price
      t.decimal :other_twin_beds_settlement_price
      t.integer :breakfast, default: 0
      t.integer :car, default: 0
      t.decimal :tax_rate, default: 0
      t.decimal :tax_point, default: 0


      t.timestamps
    end
  end
end

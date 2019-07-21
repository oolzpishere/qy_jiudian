class CreateConferences < ActiveRecord::Migration[5.2]
  def change
    create_table :conferences do |t|
      t.string :name
      t.string :sale_from
      t.string :sale_to

      t.timestamps
    end
  end
end

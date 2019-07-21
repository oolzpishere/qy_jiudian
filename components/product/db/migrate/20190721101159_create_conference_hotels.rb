class CreateConferenceHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :conference_hotels do |t|

      t.timestamps
    end
  end
end

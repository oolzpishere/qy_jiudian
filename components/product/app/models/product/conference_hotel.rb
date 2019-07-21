module Product
  class ConferenceHotel < ApplicationRecord
    self.table_name = :conference_hotels

    belongs_to :conference
    belongs_to :hotel
  end
end

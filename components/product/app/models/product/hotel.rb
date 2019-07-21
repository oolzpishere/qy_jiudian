module Product
  class Hotel < ApplicationRecord
    self.table_name = :hotels

    has_many :conference_hotels
    has_many :conferences, through: :conference_hotels
  end
end

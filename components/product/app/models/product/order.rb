module Product
  class Order < ApplicationRecord
    self.table_name = :orders
  end
end

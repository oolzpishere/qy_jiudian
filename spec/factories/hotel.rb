FactoryBot.define do
  factory :hotel, class: "Product::Hotel" do
    id {1}
    name {"hotel-name"}
    conference_ids {["1"]}
    breakfast {"0"}
    car {"0"}
    tax_rate {"0.15"}
    tax_point {"10"}
  end

  factory :hotel_room_type do
    hotel
    room_type
    price { "100" }
    settlement_price {"200"}
  end

  factory :hotel_new, class: "Product::Hotel" do
    id {1}
    name {"hotel-name-new"}
    conference_ids {["1"]}

    breakfast {"0"}
  end
end

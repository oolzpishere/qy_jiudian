FactoryBot.define do
  factory :hotel, class: "Product::Hotel" do
    id {1}
    name {"hotel-name"}
    conference_ids {["1"]}
    twin_beds {"25"}
    queen_bed {"20"}
    three_beds {"15"}
    other_twin_beds {"10"}
    twin_beds_price {"250"}
    queen_bed_price {"280"}
    three_beds_price {"150"}
    other_twin_beds_price {"100"}
    breakfast {"0"}
  end

  factory :hotel_new, class: "Product::Hotel" do
    id {1}
    name {"hotel-name-new"}
    conference_ids {["1"]}
    twin_beds {"25"}
    queen_bed {"20"}
    three_beds {"15"}
    other_twin_beds {"10"}
    twin_beds_price {"250"}
    queen_bed_price {"280"}
    three_beds_price {"150"}
    other_twin_beds_price {"100"}
    breakfast {"0"}
  end
end

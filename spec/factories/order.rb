FactoryBot.define do
  factory :order, class: "Product::Order" do
    id {1}
    group {1}
    count {1}
    association :conference, factory: :conf
    # conf
    # conference_id {""}
    hotel
    # hotel_id {""}
    room_type {"twin_beds"}
    names {"one,two"}
    contact {"three"}
    phone {"15977793123"}
    price {220}
    breakfast {1}
    checkin {"2019-10-28"}
    checkout {"2019-11-3"}
    nights {"5"}
    total_price {1100}
    # rooms_attributes:
  end

  factory :order_new, class: "Product::Order" do
    id {1}
    group {2}
    count {1}
    association :conference, factory: :conf
    # conf
    # conference_id {""}
    hotel
    # hotel_id {""}
    room_type {"twin_beds"}
    names {"one,two"}
    contact {"three"}
    phone {"15977793123"}
    price {220}
    breakfast {1}
    checkin {"2019-10-28"}
    checkout {"2019-11-3"}
    nights {"5"}
    total_price {1100}
    # rooms_attributes:
  end

end

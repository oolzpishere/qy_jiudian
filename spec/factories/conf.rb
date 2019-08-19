FactoryBot.define do
  factory :conf, class: "Product::Conference" do
    id { 1 }
    name { "conf" }
    sale_from { "2019-10-28"}
    sale_to { "2019-11-03" }
  end
end

FactoryBot.define do
  factory :admin, class: "Account::Admin" do
    id { 1 }
    email { Faker::Internet.email }
    password { "password"}
    password_confirmation { "password" }
  end
end

FactoryBot.define do
  factory :manager, class: "Account::Manager" do
    id { 1 }
    email { Faker::Internet.email }
    password { "password"}
    password_confirmation { "password" }
  end
end

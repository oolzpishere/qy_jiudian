FactoryBot.define do
  factory :user, class: "Account::User" do
    id { 1 }
    email { Faker::Internet.email }
    password { "password"}
    password_confirmation { "password" }
  end
end

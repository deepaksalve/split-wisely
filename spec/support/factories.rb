require 'faker'

FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    password "ruby123"
    password_confirmation "ruby123"
  end
end

require 'faker'

FactoryGirl.define do
  factory :group do
    title Faker::Book.title
    description 'Group description'
  end
end

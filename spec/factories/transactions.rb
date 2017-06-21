FactoryGirl.define do
  factory :transaction do
    group_id 1
    user_id 1
    date "2017-06-20"
    amount "9.99"
    amount_paid "9.99"
  end
end

# frozen_string_literal: true
FactoryBot.define do
  factory :subscription do
    customer
    tea
    title { Faker::Marketing.buzzwords }
    price { [9.99, 10.99, 11.99, 12.99, 13.99, 14.99, 15.99].sample  }
    status { ['active', 'cancelled'].sample }
    frequency { ['monthly', 'quarterly'].sample }
  end
end

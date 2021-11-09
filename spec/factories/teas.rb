FactoryBot.define do
  factory :tea do
    # Tea variety: ['Black', 'Green', 'Herbal', 'Oolong', 'White']
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.within(range: 195..212) }
    brew_time { Faker::Number.within(range: 2..10) }
  end
end

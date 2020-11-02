FactoryBot.define do
  factory :task do
    description { Faker::Lorem.sentence }
    list
  end
end

FactoryBot.define do
  factory :list do
    description { Faker::Lorem.sentence }
    is_private { false }
    user

    trait :has_parent do
      parent_list { association :list }
    end

    factory :sublist, traits: %i[has_parent]
  end
end

FactoryBot.define do
  factory :list do
    description { Faker::Lorem.sentence }
    is_private { false }
    sublist_max_level { 0 }
    user

    trait :has_parent do
      user { nil }
      parent_list { association :list }
    end

    factory :sublist, traits: %i[has_parent]
  end
end

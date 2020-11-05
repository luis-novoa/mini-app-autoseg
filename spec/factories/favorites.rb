FactoryBot.define do
  factory :favorite do
    user
    list
    user_list { "#{user.id}_#{list.id}" }
  end
end

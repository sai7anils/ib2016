FactoryGirl.define do
  factory :idea do
    user { FactoryGirl.create(:user) }
    title { Faker::Name.title }
    description { Faker::Lorem.sentence }
    idea_type false
  end
end
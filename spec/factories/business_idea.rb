FactoryGirl.define do
  factory :business_idea do
    idea { FactoryGirl.create(:idea) }
    business_line 1
    problem_statement { Faker::Lorem.characters(90) }
    solution { Faker::Lorem.characters(90) }
    idea_stage { Faker::Lorem.word }
    ip_patent { Faker::Internet.ip_v4_address }
    motivation_vision { Faker::Lorem.word }
    year_exp DateTime.now.year
    business_model { Faker::Lorem.word }
    des_business_model { Faker::Lorem.characters(90) }
    tagline { Faker::Lorem.word }
    business_idea_type 1
    startup_business 1
  end
end
FactoryGirl.define do
  factory :user do
    username { Faker::Lorem.characters(10) }
    email { Faker::Internet.free_email }
    country { Faker::Address.country }
    city { Faker::Address.city }
    region { Faker::Address.state }
    password { Faker::Internet.password }
    user_type 2
    password_confirmation { password }
    confirmed_at DateTime.now

    trait :admin do
      user_type 1
    end

    trait :entrepreneur do
      user_type 2
    end

    trait :startup do
      user_type 3
    end

    trait :investor do
      user_type 4
    end
  end
end
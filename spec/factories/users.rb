FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foobar#{n}@example.org" }
    sequence(:username) { |n| "foobar#{n}" }
    password 'password'
    confirmed_at { Time.zone.now }

    trait :unconfirmed do
      confirmed_at nil
    end

    trait :admin do
      role :admin
    end
  end
end

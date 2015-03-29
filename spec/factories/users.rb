FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foobar#{n}@example.org" }
    sequence(:username) { |n| "foobar#{n}" }
    password 'password'

    trait :admin do
      admin true
    end
  end
end

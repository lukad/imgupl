FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foobar#{n}@example.org" }
    sequence(:username) { |n| "foobar#{n}" }
    password 'password'
    confirmed_at { Time.zone.now }
    role :user

    trait :unconfirmed do
      confirmed_at nil
      role :guest
    end

    factory :guest, traits: [:unconfirmed] do
      role :guest
    end

    factory :mod do
      role :mod
    end

    factory :admin do
      role :admin
    end
  end
end

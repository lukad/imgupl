FactoryGirl.define do
  sequence :email do |n|
    "foobar#{n}@example.org"
  end

  sequence :username do |n|
    "foobar#{n}"
  end

  factory :user do
    username
    email
    password 'password'
  end
end

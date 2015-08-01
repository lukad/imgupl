FactoryGirl.define do
  factory :comment do
    sequence(:body) { |n| "MyText_#{n}" }
    upload
    user
  end
end

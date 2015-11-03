FactoryGirl.define do
  factory :presentation do
    title 'sample'
    association :user
    association :meeting
  end
end

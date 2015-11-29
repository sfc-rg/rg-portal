FactoryGirl.define do
  factory :user_judgment do
    association :presentation
    association :user
    passed false
  end
end

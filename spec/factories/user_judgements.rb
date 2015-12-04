FactoryGirl.define do
  factory :user_judgement do
    association :presentation
    association :user
    passed false
  end
end

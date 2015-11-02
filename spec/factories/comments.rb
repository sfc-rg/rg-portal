FactoryGirl.define do
  factory :comment do
    content 'This is a comment.'
    association :user
  end
end

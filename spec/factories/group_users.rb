FactoryGirl.define do
  factory :group_user do
    association :user
    association :group
  end
end

FactoryGirl.define do
  factory :privilege do
    model 'MyString'
    action 'MyString'
    association :user
  end
end

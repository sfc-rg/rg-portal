FactoryGirl.define do
  factory :privilege do
    model 'model'
    action 'action'
    association :user
  end
end

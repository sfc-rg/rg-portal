FactoryGirl.define do
  factory :blog do
    title 'blog title'
    content 'This is a my blog.'
    association :user
  end
end

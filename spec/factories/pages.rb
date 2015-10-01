FactoryGirl.define do
  factory :page do
    path 'sample'
    title 'sample'
    content 'This is a page.'
    association :user
  end
end

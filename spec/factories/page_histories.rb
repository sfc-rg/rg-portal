FactoryGirl.define do
  factory :page_history do
    path 'sample'
    title 'sample'
    content 'This is a page.'
    association :page
    association :user
  end
end

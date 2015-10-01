FactoryGirl.define do
  factory :page_history do
    path 'sample'
    title 'sample'
    content_diff ''
    association :page
    association :user
  end
end

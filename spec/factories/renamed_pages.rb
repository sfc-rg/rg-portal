FactoryGirl.define do
  factory :renamed_page do
    before_path '2015s/A'
    after_path '2015s/B'
  end
end

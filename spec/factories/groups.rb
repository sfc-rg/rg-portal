FactoryGirl.define do
  factory :group do
    name { |n| "ARCH#{n}" }
    kind :kg
  end
end

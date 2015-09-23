FactoryGirl.define do
  factory :meeting do
    name '講義1'
    start_at 1.hour.ago
    end_at 1.hour.since
  end
end

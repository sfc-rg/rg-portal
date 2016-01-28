FactoryGirl.define do
  factory :meeting do
    name '講義1'
    content 'This is a meeting'
    start_at 1.hour.ago
    end_at 1.hour.since
    accepting true
  end
end

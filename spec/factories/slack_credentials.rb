FactoryGirl.define do
  factory :slack_credential do
    sequence(:slack_user_id) { |n| "U03AE1H0U#{n}" }
  end
end

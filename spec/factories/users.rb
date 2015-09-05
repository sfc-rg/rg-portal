FactoryGirl.define do
  factory :user do
    name 'Yusei Yamanaka'
    email 'sfc@example.com'
    icon_url 'placehold.it/128x128'
    association :slack_credential
  end
end

FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'email@example.com'
    icon_url 'placehold.it/128x128'
    association :slack_credential
    association :ldap_credential
    group_users { [build(:group_user, user: id)] }
  end
end

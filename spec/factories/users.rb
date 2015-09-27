FactoryGirl.define do
  factory :user do
    name 'Yusei Yamanaka'
    email 'sfc@example.com'
    icon_url 'placehold.it/128x128'
    role :general
    association :slack_credential
    association :ldap_credential
    group_users { [build(:group_user, user: id)] }
  end
end

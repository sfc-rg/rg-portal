FactoryGirl.define do
  factory :ldap_credential do
    sequence(:uid) { |n| "testuser_#{n}" }
    sequence(:uid_number) { |n| 12345 + n }
    gid_number 1000
    gecos 'Test User, SFC, 71234567, t12345ut@sfc.keio.ac.jp'
    sequence(:student_id) { |n| 71234567 + n }
  end
end

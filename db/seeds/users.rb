User.delete_all
SlackCredential.delete_all
LdapCredential.delete_all
GroupUser.delete_all

slack_user_id = ENV['SLACK_USER_ID'] || 'U03AA0BC0'

user = User.create!(
  email: 'email@exsample.com',
  name: 'Test User',
  nickname: 'testuser',
  icon_url: 'http://placehold.it/128x128',
  role: :admin
)
user.build_slack_credential(slack_user_id: slack_user_id).save!
user.build_ldap_credential(
  uid: 'testuser',
  uid_number: 12345,
  gid_number: 1000,
  gecos: 'Test User, SFC, 71234567, t12345ut@sfc.keio.ac.jp',
  student_id: 71234567
).save!
user.group_users.build(group: Group.first).save!

groups = Group.all

50.times do |i|
  user = User.create!(
    email: "email#{i}@exsample.com",
    name: "Test User #{i}",
    nickname: "testuser_#{i}",
    icon_url: 'http://placehold.it/128x128',
    role: :general
  )
  user.build_slack_credential(slack_user_id: "U03AA0BD#{i}").save!
  user.build_ldap_credential(
    uid: "testuser_#{i}",
    uid_number: 12350 + i,
    gid_number: 1000,
    gecos: "Test User #{i}, SFC, 7123457#{i}, t1234#{i}ut@sfc.keio.ac.jp",
    student_id: 71234570 + i
  ).save!
  user.group_users.build(group: groups.sample).save!
end

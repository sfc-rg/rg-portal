FactoryGirl.define do
  factory :line_credential do
    encrypted_line_user_id 'U206d25c2ea6bd87c17655609a1c37cb8'
    display_name 'LINE taro'
    picture_url 'http://obs.line-apps.com/ub00b9ac609e51f4707cd86d8e797491b/1'
    association :user
  end
end

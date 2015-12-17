FactoryGirl.define do
  factory :upload do
    content_type 'image/png'
    association :user
    after :create do |upload|
      upload.update_column(:file, 'upload.png')
    end
  end
end

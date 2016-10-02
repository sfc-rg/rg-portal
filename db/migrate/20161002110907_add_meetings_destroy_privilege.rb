class AddMeetingsDestroyPrivilege < ActiveRecord::Migration
  def up
    User.first(1).each do |user|
      Privilege.create!(user: user, model: 'meetings', action: 'destroy')
    end
  end

  def down
  end
end

class ChangeRoleToPrivilege < ActiveRecord::Migration
  def up
    User.where(role: 20).each do |user|
      user.privileges.create!(model: 'user_judgments', action: 'index')
      user.privileges.create!(model: 'meetings', action: 'update')
    end
  end

  def down
  end
end

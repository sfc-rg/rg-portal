class ChangeRoleToPrivilege < ActiveRecord::Migration
  def up
    User.find_each do |user|
      if user.admin?
        user.privileges.create!(model: 'user_judgments', action: 'index')
        user.privileges.create!(model: 'meetings', action: 'update')
      end
    end
  end

  def down
  end
end
